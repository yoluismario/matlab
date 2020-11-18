%% Carpeta 2019 - FLUIDOS IA



% problema 3.1
clear all
disp('problema 3.1')
r =     0.5 ;
H =     1.5; 
q_t = 5*.1^3;
t_f =  sqrt((2*pi*r^2*H)/q_t)

% problema 3.2
clear all
disp('problema 3.2')
k 	=		4;
r0	= 		0.005;
g	=		9.81;
H 	=		1;
t = 2/3*H^(1.5)/(k*r0^2*sqrt(2*g))

% problema 3.3
clear all
disp('problema 3.3')
rel_rho_i = 	1.08;
Vol_0 	=		10; %[m3]
porc_0	=		1.02;
Qa 		= 		10*0.001; %[dm3/s]

t =	-Vol_0/Qa*log((porc_0-1)/(rel_rho_i-1));
t_minutos = t/60

%% Conservacion de cantidad de movimiento
% problema 3.7

%% ejercicio LEV
clear all
omega1 = 12000;
omega2 = 10000;
mu = 0.12;
e = 0.0007;
D = 0.05;

Pot = mu* omega2*pi*D^4*(omega1-omega2)/(32*e)





%% Parcial 1
clear; clf


Dp = -10; mu = 0.1; Ro = 0.005; Ri=0.001; 

cte = -1.4912e-05;
U=@(r) -(Dp/(4*mu))*(Ro^2-r^2+(Ro^2-Ri^2)/(log(Ri/Ro))*log(Ro/r));
% U1=@(r) -(Dp/(4*mu))*(Ro^2-r^2-2.4e-2*r); +(0.8187-exp(Ri)
U1=@(r) (Dp/(4*mu))*((r-Ro)*(r-Ri));

r = 0.0004:0.0001:0.006;

for i = 1:size(r,2)
    u_i(i) = U(r(i));
    u_j(i) = U1(r(i));
end
plot(r,u_i,r,u_j); grid on
% ylim([0 0.0003])


s  = -(exp(-r)-exp(-Ro)).*(exp(-r)-exp(-Ri)); %1.6094/(Ri-Ro).*r+2.0114;
% s1 = log(Ro./r);,r,s1
plot(r,s)
grid on


xlabel('r [m]')

%% problema 2
clear
H = 2;
D = 0.05;
m = 10;
mu_f = 0.55;
g  = 9.81;
rho = 998;
theta = 60;

V = sqrt(2*H*g)
Rx = rho*V^2*pi*D^2/4*cosd(theta)
F_f = m*mu_f*g
disp('no se mueve')

%% problema 3
clear
U_inf = 3;
delta = 0.0015;
w = 1.5;
L = 2;

Qcd = U_inf*delta*w*2/3
Qab = w*delta*U_inf
Qad = L*w*0.0002

Qbc = Qab-Qcd-Qad


%% problemas bernoulli

% Problema canal
h_1     = 1.5;
V_1     = 3;
H       = 4;
g       = 9.81;

h0      = -(h_1*V_1)^2/(2*g);
h1      = 0;
h2      = (V_1^2/(2*g)+h_1+H);
h3      = -1;
p       = [h3 h2 h1 h0]

r = roots(p)

% V_2 con h_max
V_2_min = V_1*h_1/r(1)

% V_2 con h_min
V_2_max = V_1*h_1/r(2)



%% capa límite
% Problema 48

Ue = 9.25;
rho = 1.225; 
mu = 1.78e-5;
x = 1.22;
Re_x = rho*Ue*x/mu

delta_x = 5 * x/sqrt(Re_x)
% caudal 

% problema 11.2

%% problema flujo externo
% 




