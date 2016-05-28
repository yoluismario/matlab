% function time_all = placa_aero()
% versión con la normal calculada
tic
clear;close all;
graf =0;% si es 0 no grafica
% Placa plana con las normales
% tenemos que leer un archivo con los datos de entrada
%% definiciones de entrada
    A = importdata('entrada.txt');
    % carga de las variables del archivo de entrada
    a = A.data(1); 
    b = A.data(2);
    nel = A.data(5); % numero de elementos
    theta = A.data(4);
    h = A.data(3);
    vel = A.data(6);
%% FUNCIONES DE TRANSFORMACION
 thetaR = -deg2rad(theta); % en grados

% chequear que a no sea mayor que 2b
	dosB = 2*b; dosA = 2*a;
if dosA>b
	disp('2a es mayor que b')
    return
end


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
nvp = nnp; % numero de vortex points
ncp = nnp; % numero de control points
% iniciar las matrices
rnpB =zeros(3,nnp);
rvpB =zeros(3,nnp);
rcpB =zeros(3,nnp);
normB =zeros (3,nnp);

% definir en B
rnpB(:,1)=baB';
for i=1:nel
    rnpB(1,i+1) = lel*i-ba;
	rvpB(1,i+1) = rnpB(1,i+1)-lel*.75;
	rcpB(1,i+1) = rnpB(1,i+1)-lel*.25;
end
normB = rcpB+kron([0; 1; 0],ones(1,nnp)); %normales
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
cnormN = normN-rcpN;% componenetes de la normal en N

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
	 hold off
    otherwise 
        disp('no grafica')
end

%% calcular la vorticidad

%% calcular la conveccion


time_all = toc;
disp(time_all)

%% CORREGIR rnpB(1) = primer nodo





