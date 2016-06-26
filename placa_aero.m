% function time_all = placa_aero()
% versión de placa plana con la normal calculada
tic
clear;%close all;
graf =0;% si es 0 no grafica
ndt = 4;%numero de pasos de tiempo
cutoff=1e-6;
% tenemos que leer un archivo con los datos de entrada
%% definiciones de entrada
    DAT = importdata('entrada.txt');
    % carga de las variables del archivo de entrada
    a = DAT.data(1); 
    b = DAT.data(2);
    nel = DAT.data(5); % numero de elementos
    theta = DAT.data(4);
    h = DAT.data(3);
    vel = DAT.data(6);
    alfa = DAT.data(7);
    tf = ndt;% tomamos el tiempo como unitario
%% FUNCIONES DE TRANSFORMACION
alfaR = deg2rad(alfa);
thetaR = -deg2rad(theta); % en grados
% chequear que a no sea mayor que 2b
	dosB = 2*b; dosA = 2*a;
if dosA>b
	disp('2a es mayor que b')
    return
end

%% ORIGEN DE COORDENADAS
% definimos un centro de coordenadas origen ceroN
ceroN = zeros(1,3);
ceroB = ceroN;
B = [0 h 0];
% versores en el origen B
nb1 = [1 0 0];
nb2 = [0 1 0];

% matrices de rotacion
CBN = [cos(thetaR) sin(thetaR) 0;-sin(thetaR) cos(thetaR) 0; 0 0 1];
CNB = CBN';

ba = (1+a)*b;
bf = dosB-ba;
baB = -ba*nb1; % borde de ataque en B
bfB = bf*nb1; % borde de fuga en B
baN = CNB * baB' + B';
bfN = CNB * bfB' + B';
% fijar un centro de coordenadas
ceroN = ceroB + B;

lel = dosB/nel;%longitud elemento
% generacion de elementos
nnp = nel+1; % numero de nodal points
nvp = nel; % numero de vortex points
ncp = nel; % numero de control points
% iniciar las matrices
rnpB =zeros(3,nnp);
rvpB =zeros(3,nvp);
rcpB =zeros(3,ncp);
% normB =zeros (3,nnp);

% definir en B
rnpB(:,1)=baB';
for i=1:nel
    rnpB(1,i+1) = lel*i-ba;
	rvpB(1,i) = rnpB(1,i+1)-lel*.75;
	rcpB(1,i) = rnpB(1,i+1)-lel*.25;
end
normB = rcpB+kron([0; 1; 0],ones(1,ncp)); %normales
%% tranformar a N
rnpN = CNB *rnpB;
rvpN = CNB *rvpB;
rcpN = CNB *rcpB;
normN = CNB* normB;
%% vectores con B sumado
RnpN(2,:) = rnpN(2,:)+h;
RcpN(2,:) = rcpN(2,:)+h;
RvpN(2,:) = rvpN(2,:)+h;
NormN(2,:) = normN(2,:)+h;

cnormB = normB-rcpB;
cnormN = normN-rcpN;% componentes de la normal en N

switch graf
    case 1
%     if graf ==1;
     figure('Name','Sistema N','NumberTitle','off')
	 graficar = [ceroN;ceroB;baN';bfN'];
	 plot(graficar(:,1),graficar(:,2),'*')
	 grid on
 	 hold on
	 %plot(rnpB(1,:),rnpB(2,:),'bs') plot(rvpB(1,:),rvpB(2,:),'bo')
	 %plot(rcpB(1,:),rcpB(2,:),'b*')
	 % en sistema N
	 plot(rnpN(1,:),RnpN(2,:),'gs')
	 plot(rvpN(1,:),RvpN(2,:),'ro')
	 plot(rcpN(1,:),RcpN(2,:),'r*')
     quiver(rcpN(1,:),rcpN(2,:),cnormN(1,:),cnormN(2,:),.5)
     plot(B(1),B(2),'ys')
	 legend('puntos claves','nodos','vortices','control','Punto B')
% 	 hold off
    otherwise 
        disp('no grafica')
end

%% VELOCIDADES
% definimos las velocidades a emplear: velocidad del cuerpo, velocidad en
% el infinito, velocidad de la estela y velocidad inducida por los vortices
% adheridos a la placa
v_solid =[0 0 0];
v_wake =[0 0 0];
v_inf = vel*[cos(alfaR) sin(alfaR) 0]; 
VelN = v_wake+v_inf-v_solid;

%% calcular la vorticidad



% resolver el problema A*G=b
A = rand(nel); 
A_amp =sumarCol(A);
% G = zeros(nel+1,1);G(end,1)=1;
[LA,UA]=lu(A);



RHS = vectRHS(VelN,normN);% funcion
G = RHS\A_amp;
% G = inv(A_amp)*RHS; % NO RECOMENDADO!!!!!
G_new = zeros(nel+1);
G_old =G;
GB= zeros(nel+1,ndt); GW = zeros(ndt);






for t=0:ndt    
%% convectar la estela
% xpos_v= vN * ndt
% GB = G_old; 





end
time_all = toc;
disp(time_all)

%% CORREGIR rnpB(1) = primer nodo

%function vB = CBN(vN,theta)
%rad = deg*pi/180;


