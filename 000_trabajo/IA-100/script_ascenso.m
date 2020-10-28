% cargar los datos de cada avion por separado

masa_basica = 900; % kg
pilotos = 180;     % kg
combustible = 200; % kg
avion.name = "IA-100";

% datos del avion
avion.masa_i = masa_basica + pilotos + combustible; 
avion.W  = (masa_basica + pilotos + combustible)*9.81; % N 
avion.WF = combustible *9.81;
avion.WE = (masa_basica + pilotos)*9.81;
avion.Sw = 9;    % m^2
avion.d = 1.9304; % d diámetro en [m]
avion.D = avion.d*3.280839895013123;% D diámetro de hélice en [pies]
avion.SFC = 275/1000*9.81/3600

% condicion de vuelo
condicion.h = 1000;    % [m]
condicion.hft = condicion.h/0.3048; %[ft]
condicion.D_ISA = 10;
condicion.KTAS = 140;

[ ~, ~, rho, snd_spd,~] = ISAatm(condicion.h,condicion.D_ISA);
condicion.rho = rho;
condicion.VTAS = condicion.KTAS*.54111; % m/s
condicion.Mach = condicion.VTAS/snd_spd;

condicion.CL = avion.W / (condicion.rho/2*avion.Sw*condicion.VTAS^2)

% definicion de polares del avion
CD_limpio=@(CL)0.0350- 0.0381*CL + 0.085*CL^2;
CD_tren  =@(CL)0.0303- 0.0134*CL + 0.0698*CL^2;
condicion.CD1 = CD_limpio(condicion.CL);
condicion.CD2 = CD_tren(condicion.CL);

D_limpio = condicion.CD1*avion.Sw*condicion.VTAS^2*condicion.rho/2
D_tren = condicion.CD2*avion.Sw*condicion.VTAS^2*condicion.rho/2

condicion.drag2lift1 = condicion.CD1/condicion.CL;
condicion.drag2lift2 = condicion.CD2/condicion.CL;

% ecuación de Breguet, rango
eta = 0.88; 
R_km1 = eta/(avion.SFC*condicion.drag2lift1)*log(1+avion.WF/avion.WE);
R_km2 = eta/(avion.SFC*condicion.drag2lift2)*log(1+avion.WF/avion.WE);

% graficos_comp_polares
bar([R_km1 R_km2],'Horizontal','on')

% costo por km recorrido
comb_costo_kg = 300;
cost_1 = avion.WF*300/R_km1
cost_2 = avion.WF*300/R_km2
bar([cost_1 cost_2],'Horizontal','on')


% funcion de relacion de avance (J)
f_J=@(Vk,n,D)1.689*Vk/(n*D); %extraido de notas de Hartzell

% funcion de coeficiente de potencia (CP)
Cp=@(HP,rho,n,D)550*HP/(rho*n^3*D^5);

% Cálculo del Mach de puntera considerando la rotación de la hélice y la velocidad de avance
M_tip=@(snd_spd,V_ifty,n,Dp)(V_ifty^2+(pi*n*Dp)^2)^0.5/snd_spd;

% funcion implicita de la traccion
T=@(Ct,rho,n,D)Ct*rho*n^2*D^4;

% Lectura de datos de hélice y motor
% PROP_DATA: levanta los archivos de la hélice
% ENG_DATA: levanta los datos de motor
[beta, CT eta] = PROP_DATA();
[RPM PLA PRESALT ENG_PWR ENG_FF ] = ENG_DATA(0);

avion.propeller.beta = beta;
avion.propeller.CT   = CT;
avion.propeller.eta  = eta;

avion.engine.PWR = ENG_PWR;
avion.engine.FF  = ENG_FF;

%airplane = chooseAirplane;



% https://la.mathworks.com/help/matlab/ref/msgbox.html
%f = msgbox('Operación completada','Funciona');

% Ingreso de variables de cálculo
% velocidades = [60:15:195]; % Velocidades en [KTAS]
