% # Carpeta de Fluidos IA 2017
% Ejercicio 1.1
rho_0 = 1025;% kg/m^3
g = 9.0865; % m/s^2
% opcion a) incompresible
Dh = 10000;%m
Dp = rho_0*g*Dh;% [Pa]
Dp_atm = Dp/101325; %[atm]

% Ejercicio 8



% Ejercicio 9
syms y
b = 4; y_max =0.61;
A = b * y_max
rho(y)=128.81*(10-3.281*y)
u(y) = 10*(4*y-3.281*y^2)
% caudal másico
m_punto = int(b*rho*u,y,0,0.61);
% caudal volumetrico / área
V_media = int(b*u,y,0,0.61)/A;

% problema 14
clear
rho = 998;
d_sal =2*0.0254;
A_sal = pi/4*d_sal^2;
d_ent =4*0.0254;
A_ent = pi/4*d_ent^2;
vm_sal = 18;
vm_ent =A_sal/A_ent*vm_sal
p1_man =170E3; % Pa
Fx = -rho * vm_ent^2*cosd(45)*A_ent+rho*A_sal*vm_sal^2*cosd(30)...
    -p1_man *A_ent*cosd(45);

Fz = -rho * vm_ent^2*sind(45)*A_ent-rho*A_sal*vm_sal^2*sind(30)...
    -p1_man *A_ent*sind(45);

% parcial 1 

% ejercicio 1 parcial embrague hidraulico
clear
w1 = 10000/60*2*pi;
w2 = 9000/60*2*pi;
D = 0.45;
%a = 0.005;

mu = 0.01;
P = 20;%w2*T
a = mu*pi*(w1-w2)*D^4/(32*P/w2)

T = mu*pi*(w1-w2)*D^4/(32*a)

T = 12000;


% ejercicio 2 parcial cono
clear
V = 20;
D = 0.12;
R = 0.3;
h = D^2/(8*R)
alfa = 35;
rho = 998;
Feq = rho*V^2*(pi*D^2/4)*(1-cosd(alfa))
k = 80000;
dx = Feq/k

% ejercicio 3 parcial tubo
clear
syms x
l = 0.9; A = 0.12;
Q0 = 300;
Qe = (110/l^2)*x^2;
Qs = 130 - (130/0.9)*x

Vm = (Q0 + int(Qe,x,0,l) - int(Qs,x,0,l))/(1000*A)


% problema tobera
syms x
v2 = 11.3;
v1 = 7.5;
x1 = 0;
x2 = 0.8;
b = .05;
f_v =(v2-v1)*x+v1;
int(f_v,x,x1,x2)

% problema 28
clear
d = 0.005; 
D0 = 0.1;
D2 = 0.075; A2 = pi/4*D2^2;
D1 = 0.15; A1 = pi/4*D1^2;
l_a = (D1-D2)/2;
W = 24*9.80665;
P0 = -W/(pi/4*(D0^2-d^2));
rho = 998; g = 9.80665;
Q = sqrt(2*(P0/rho)/((1/A1^2)-(1/A2^2)))











