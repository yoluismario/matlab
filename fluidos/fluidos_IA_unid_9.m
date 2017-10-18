% ejercicios de la unidad 9
%% Problema 42
% modelo escala 1:10 
rho_aire = 1.225;
mu_aire = 1.81e-5; % [N.s/m^2]
a = 340;
escala = 1/10;

S_prot = 16.6;
S_mod = S_prot/100;
% si V_prot = 300 km/h
V_p = 300/3.6; % [m/s]
V_mod = V_p / escala
M_mod = V_mod/a
% Mach supersónico
% si modelo a v=90 m/s, D = 29 N.
V_mod = 90;
D_m = 29;
CD = D_m/(V_mod^2*S_mod*0.5*rho_aire);
D_p = D_m*S_prot*V_p^2/(S_mod*V_mod^2)

%% Problema 43
% La velocidad es 3 veces la del prototipo

U_m = 90/3.6*3

%% Problema 46
% Usando el coeficiente de momento
U_p = 60/3.6
rho_agua = 998;
mu_agua = 1e-3;
nu_agua = mu_agua/rho_agua;
nu_aire = mu_aire/rho_aire;
U_m = 10*U_p*nu_agua/nu_aire

q_m = U_m^2*rho_agua/2
q_p = U_p^2*rho_aire/2
M_m = 1740; %[N/m]

M_p = 1000*M_m*q_p/q_m




