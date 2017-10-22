%% ejercicio 1
h = 40;
b = 70;
E = 2.1e6;
nu = .3; 
S_f = 2100; % Tension de fluencia

A = h*b/2;

u1 = [0.02 -0.04];
u2 = [0.03 -0.04];
u3 = [0.03 -0.01];
% matriz con los desplazamientos en filas
U = [u1;u2;u3];

Coord=[h 0 0; 0 b 0];
a1 = Coord(:,3)-Coord(:,2);
a2 = Coord(:,1)-Coord(:,3);
a3 = Coord(:,2)-Coord(:,1);
% matriz con las a_i en columnas
B = [a1 a2 a3];

% deformaciones
disp('deformaciones:')
eps_11 = -1/(2*A)*dot(U(:,1),B(2,:))
eps_22 = 1/(2*A)*dot(U(:,2),B(1,:))
eps_12 = (dot(U(:,1),B(1,:))-dot(U(:,2),B(2,:)))/(4*A)

% tensiones
disp('tensiones:')
s_11 = (eps_11+eps_22*nu)*E/(1-nu^2)
s_22 = (eps_11*nu+eps_22)*E/(1-nu^2)
s_12 = eps_12*E*(1+nu)^(-1)

% comparacion
s_comp = sqrt(s_11^2+s_22^2-s_11*s_22+3*s_12^2)
CS = S_f/s_comp

clear 


%% ejercicio 2
disp('ejercicio 2:')
L1 = 80;
L2 = 150;
h = 1;
E = 2.1e6;
nu = .3; 
P = 80000;
S_f = 2100; % Tension de fluencia

A = L1*L2/2
% elemento I
Coord = [L1 0 L1 0 ;0 0 L2 L2];
conect = [1 3 4; 1 4 2];
a1 = Coord(:,4)-Coord(:,3)

K11_11 = (E*h)/(4*A*(1-nu^2))*(a1(2)^2+(1-nu)/2*a1(1)^2);
K12_11 = (E*h)/(4*A*(1-nu^2))*(-a1(2)*a1(1)*nu+(1-nu)/2*a1(2)*a1(1));
K22_11 = (E*h)/(4*A*(1-nu^2))*(a1(1)^2+(1-nu)/2*a1(2)^2);

%K_11 = [K11_11 K12_11; K12_11 K22_11]

% elemento II
a1 = Coord(:,2)-Coord(:,4);

K11_11 = K11_11+(E*h)/(4*A*(1-nu^2))*(a1(2)^2+(1-nu)/2*a1(1)^2);
K12_11 = K12_11+(E*h)/(4*A*(1-nu^2))*(-a1(2)*a1(1)*nu+(1-nu)/2*a1(2)*a1(1));
K22_11 = K22_11+(E*h)/(4*A*(1-nu^2))*(a1(1)^2+(1-nu)/2*a1(2)^2);

K_11 = [K11_11 K12_11; K12_11 K22_11]
P_11 = [0; -P]
% desplazamientos
X = K_11\P_11

% matriz con los desplazamientos en columnas
U = [X(1) 0 0 0;X(2) 0 0 0];

% elemento 1
Coord = [L1 0 L1 0 ;0 0 L2 L2];
a1 = Coord(:,4)-Coord(:,3)
a2 = Coord(:,1)-Coord(:,4);
a3 = Coord(:,3)-Coord(:,1);
% matriz con las a_i en columnas
B = [a1 a2 a3];

% deformaciones
disp('deformaciones elemnto I:')
epsI_11 = -1/(2*A)*dot(U(1,:),B(2,:))
epsI_22 = -1/(2*A)*dot(U(2,:),B(1,:))
epsI_12 = (dot(U(1,:),B(1,:))-dot(U(2,:),B(2,:)))/(4*A)

% tensiones
disp('tensiones elemto I:')
sI_11 = (epsI_11+epsI_22*nu)*E/(1-nu^2)
sI_22 = (epsI_11*nu+epsI_22)*E/(1-nu^2)
sI_12 = epsI_12*E*(1+nu)^(-1)

% comparacion
sI_comp = sqrt(sI_11^2+sI_22^2-sI_11*sI_22+3*sI_12^2)
CSI = S_f/sI_comp

% elemento 2
a1 = Coord(:,4)-Coord(:,2)
a2 = Coord(:,1)-Coord(:,2);
a3 = Coord(:,4)-Coord(:,1);
% matriz con las a_i en columnas
B = [a1 a2 a3];

% deformaciones
disp('deformaciones elemento II:')
epsII_11 = -1/(2*A)*dot(U(1,:),B(2,:))
epsII_22 = -1/(2*A)*dot(U(2,:),B(1,:))
epsII_12 = (dot(U(1,:),B(1,:))-dot(U(2,:),B(2,:)))/(4*A)

% tensiones
disp('tensiones elemento II:')
sII_11 = (epsII_11+epsII_22*nu)*E/(1-nu^2)
sII_22 = (epsII_11*nu+epsII_22)*E/(1-nu^2)
sII_12 = epsII_12*E*(1+nu)^(-1)

% comparacion
sII_comp = sqrt(sII_11^2+sII_22^2-sII_11*sII_22+3*sII_12^2)
CSII = S_f/sII_comp
