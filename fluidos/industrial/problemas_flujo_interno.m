%% problema 6.4
disp('Problema 6.4')
L = 50; D = 0.1; alfa = 30;  g = 9.80665;  rho = 998;% agua 20ºC
z1 = 0; z2 = L*sind(alfa);
p1 = 243.4E3;  p2 = 80E3 ;

f_0 = 0.02;
f = f_0
h_L = ((z1-z2)+(p1-p2)/(rho*g))
% V = (((z1-z2)+(p1-p2)/(rho*g))*2*g*D/(L*f))


%% problema 6.5
L = 40; D_1 = 0.12; Eps = 0.25E-3;
D_2 = 0.04;
A_1 = D_1^2*pi/4;A_2 = D_2^2*pi/4;
V_2 = 25;
g = 9.80665;
rel_areas = A_2/A_1;
Delta = 2*atand((D_1-D_2)*0.5/0.1);

rho = 998; mu = 1.003E-3;

V_1 = V_2*rel_areas
Re = D_1*V_1*rho/mu 

f = f_SJ(V_1,mu/rho,D_1,Eps)
% pérdidas primarias
h_L = f*L/D_1*V_1^2/(2*g)
% perdidas secundarias
% valvula compuerta al 60%
K_v = 2;
% reduccion 
rel_areas;
Delta;
K_r = 0.05
% totales
h_s = (K_v)*V_1^2/(2*g)+K_r*V_2^2/(2*g)

% bomba
P_B = (h_s+h_L+30)*rho*g
P_B_atm = P_B/101325
%% Problema 6.6

%% Problema 6.7
clear
rho = 1.225; mu = 1.78E-5; rug = 1.5E-4; g = 9.81;
D = 0.32; A = pi*D^2/4; L = 100;
Q = 0.8 ; V = Q/A 
Re = V * rho * D/mu;
f = f_SJ(V,mu/rho,D,rug)
P2 = 998*0.01*g;
h_L = f*L/D*V^2/(2*g)
h_bomba = P2/(rho*g)+h_L+V^2/(2*g)
W_nec = Q * h_bomba*rho*g
% sección cuadrada
lado = sqrt(A/2)
Perim = 2 *(lado +lado *2)
D_H = 4*A/Perim

Re_D_H = V * rho * D_H/mu
f_D_H = f_SJ(V,mu/rho,D_H,rug)

D_eff = 64/62.19*D_H

f_D_H = f_SJ(V,mu/rho,D_eff,rug)




