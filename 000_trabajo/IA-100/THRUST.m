%function [CP_X_v,J_Y_v,M_tip_Z_v,M_FF_ij,M_T_ij] = THRUST(RPM,PRESALT,ENG_PWR,ENG_FF,CT,eta,DELTA_ISA,Machs,alturas)
%-----------GENERACIÓN DEL BANCO MOTOR PARA AVIONES DE HÉLICE-----------

%----NOTAS DEL SCRIPT---

% VERSIÓN INICIAL - 2017-05-08 - L. Soria/M. Tejeda
%   Programa de generación del banco motor, a partir de los datos de helice 
% y del motor.

%   Las funciones utilizadas están basadas en las notas de Hartzell para la
%   utilización del Map Interpolator de Hartzell Inc.
%   Las unidades usadas son en sistema imperial!!!!!

%%%%% Vectores CP, J, MTIP  %%%%%
J_v = 0:0.1:2.9;
Cp_v = 0.02:0.01:0.5;
M_tip_v = [0.5	0.6	0.7 0.8 0.9 0.95 .975];

alturas

%% % definicion de las variables de calculo
d = 1.9304;
D = d*3.280839895013123;% D diámetro de hélice en [pies], d diámetro en [m]

% funcion de relacion de avance (J)
f_J=@(Vk,n,D)1.689*Vk/(n*D); %extraido de notas de Hartzell
% funcion de coeficiente de potencia (CP)
Cp=@(HP,rho,n,D)550*HP/(rho*n^3*D^5);
% Cálculo del Mach de puntera considerando la rotación de la hélice y la velocidad de avance
M_tip=@(v_snd,V_ifty,n,Dp)(V_ifty^2+(pi*n*Dp)^2)^0.5/v_snd;
% funcion implicita de la traccion
T=@(Ct,rho,n,D)Ct*rho*n^2*D^4;

% Generación de la malla de interpolación para CT, beta y eta.
[CP_X_v,J_Y_v,M_tip_Z_v] = meshgrid(J_v,Cp_v,M_tip_v);
% Inicialización de los arreglos para datos de tracción y consumo
a = [size(RPM,2),size(Machs,2),size(alturas,2)]
M_T_ij = zeros(size(RPM,2),size(Machs,2),size(alturas,2)); 
M_FF_ij = zeros(size(RPM,2),size(Machs,2),size(alturas,2));

%M_T_ij = zeros(size(RPM,2),size(velocidades,2),size(alturas,2)); 
%M_FF_ij = zeros(size(RPM,2),size(velocidades,2),size(alturas,2)); 


% Cálculo de las condiciones para cada una de las alturas definidas en el
% vector 'alturas' y las velocidades definidas en el vector 'velocidades' o 'Machs'
% que se proporcionan como datos de ingreso en el script ENG_DECK
for i=1:size(RPM,2)
    n_i=RPM(i)/60; %convierte de RPM a rps
    for j=1:size(alturas,2)
        %Datos de ISA para la altura y DeltaISA dados
        ISA_DATA = ISAatm(alturas(j)*0.3048,DELTA_ISA);
        
        % de los datos de ISA sólo toma densidad (convertida a [slg/ft³])
        rho_j=ISA_DATA(3)/514.7058824;   
        % y velocidad del sonido
        v_sound=ISA_DATA(4);
        
	% Vector de números de Mach de vuelo: debe quitarse el comentario
	% si se ingresan valores de velocidad en ENG_DECK
        % Machs = velocidades*0.51444444/v_sound; 
        
	% Interpolación lineal. PRESALT son las alturas del banco motor, 
        % ENG_PWR las potencias en HP tomadas de ENG_DATA.m y ENG_FF los
        % consumos en tomadas de ENG_DATA.m 
        HP_ij = interp1(PRESALT,ENG_PWR(i,1:end),alturas(j));
        FF_ij = interp1(PRESALT,ENG_FF(i,1:end),alturas(j));
        % Calcula CP, MTIP, J, CT, eta y T para las condiciones dadas
        Cp_ij = Cp(HP_ij,rho_j,n_i,D);
        % M_tip_ij = M_tip(v_sound,V_inf*0.51444444,n_i,d);
        
        for k=1:size(Machs,2)
            % Vk = velocidad en nudos
            % Vk = velocidades(k);
    	    M_tip_ij = M_tip(v_sound,Machs(k)*v_sound,n_i,d);
            Vk = Machs(k)*v_sound/0.51444444;
            J_ijk = f_J(Vk,n_i,D);
            CT_ijk=interp3(CP_X_v,J_Y_v,M_tip_Z_v,CT,J_ijk,Cp_ij,M_tip_ij,'linear');
            eta_ijk=interp3(CP_X_v,J_Y_v,M_tip_Z_v,eta,J_ijk,Cp_ij,M_tip_ij,'linear');
            % Cálculo de la tracción
            T_ijk=326*eta_ijk*HP_ij/Vk;
            % Las notas de Hartzell proporcionn alternativamente la formula
            %T_ijk=CT_ijk*rho_j*n_i^2*D^4; % En este caso se tomó la
            %anterior basada en el rendimiento de la hélice por aproximar
            %mejor los valores calculados con el Map Interpolator de
            %Hartzell
            
            % Los valores calculados se almacenan en arreglos. En cada uno
            % una fila corresponde a un régimen de motor, cada columna a
            % una velocidad y cada página a una altitud
            M_T_ij(i,k,j) = T_ijk;
            M_FF_ij(i,k,j) = FF_ij;
         end
    end
end

%end 
% clearvars D f_J Cp M_tip T CP_X_v J_Y_v M_tip_Z_v n_i ISA_DATA rho_j v_sound
% clearvars HP_ij FF_ij Cp_ij M_tip_ij Vk J_ijk CT_ijk eta_ijk T_ijk i j k 
