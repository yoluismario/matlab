% ejercicios fluidos industriales
D = 0.06;
nu = 0.0002;
rho = 900;
g = 9.81; L = 10;
Q = 0.0076; 

A = pi*(D/2)^2
V = Q/A
Re = V*D/nu

f_lam=@(re) 64/re;

f_1 = f_lam(Re)

V_2 = 20; Re = V_2*D/nu
f_2 = f_SJ(V_2,nu,D,0)

h_L = f_1 * V^2/(2*g)*L/D

%% clase 3
format compact

% ejemplo genérico
D1 = 0.025; % 25mm
D2 = 0.05;  % 40mm
L1 = 5; L2 = 35;
rho = 1000; %kg/m3 agua
nu = 1.01e-6; % m2/s agua
Q = 0.0008; % m3/seg
g = 9.80655; 
% tramo recto 1
V1 = Q/(pi*D1^2/4) 
Re1 = V1*D1/nu
f_1 = f_SJ(V1,nu,D1,0.0015e-3)

V2 = Q/(pi*D2^2/4)
Re2 = V2*D1/nu
f_2 = f_SJ(V2,nu,D2,0.0015e-3)

 h_L1 = f_1*V1^2*L1/(2*g*D1)
 h_L2 = f_2*V2^2*L2/(2*g*D2)

