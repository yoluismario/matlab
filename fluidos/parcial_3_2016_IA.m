%% Parcial 
clear
%% Problema 1
% Datos:
rho = 820;D = 0.012;mu = 2E-3;
L = 5; K = 0.5; LD_valv = 55;
p1=0; p2=5*101325; g = 9.8065;
A=pi*D^2/4; 
nu = mu/rho;

% Formulas de cálculo de iterativo:
f = 0.02
for i=1:3
    V = sqrt(2*p2/rho /(f *(L/D+LD_valv)+K))
    Re=V*D/nu
    f = 0.25/(log10(5.74/Re^.9))^2
end

Q = A* V;
disp('Caudal [m^3/s]:')
disp(Q)
% Perdidas primarias
disp('Perdidas primarias [m]:')
h_prim = f *L/D*V^2/2/g;
disp(h_prim)
% Perdidas secundarias
disp('perdidas secundarias:')
h_secun = (f *LD_valv+K)*V^2/2/g;
disp(h_secun)

%% Problema 2
% Caida de una esfera en aceite SAE10W 
%
% $$D+E = W $$
%
% $$ C_D A_f \frac{\rho V^2}{2}+ \rho Vol_e g = Vol_e g \rho_e $$
clear
g = 9.8065;
% Datos
V = 0.05; rho = 920; mu = 0.1;
D = 0.01; A_f = pi*D^2/4; Vol = pi*D^3/6;

Re = D*V*rho/mu

% Debo encontrar el valor de $C_D$, para este Reynolds:
C_D = 24/Re^(0.646)
% La resistencia aerodinámica es:
D = C_D * rho*V^2/2*A_f
% Empuje
E = rho * g*Vol
% Del peso despejamos la densidad
rho_esfera = (E + D)/(Vol*g)

%% Problema 3
% Persona que succiona jugo por un sorbete.
%
% Primero se debe saber que tipo de flujo es, luego con esto se pueden
% calcular las pérdidas de carga y encontrar el $\Delta p$.
clear
g = 9.8065;
% Datos
Q = 0.000003 ; rho = 1000; mu = 1.788E-3; Dz = 0.12; nu = 1.01E-6;
D = 0.002; A = pi*D^2/4; L = 0.05 + 0.12;
p1 = 1000 * g * 0.05
V = Q/A
Re = D* V*rho/mu
% Re = D * V/nu
f = 64/Re

L_ent = 0.065 * Re * D
h_l = f * V^2/(2*g) * L/D

h_ent = f * V^2/(2*g) * L_ent/D;
h_per = Dz + h_l + h_ent -p1/(rho* g)

D_p = h_per * rho*g;

disp('Pérdida de carga primaria [m]:')
disp(h_l)
disp('Incremento pérdida en L_ent [m]:')
disp(h_ent)
disp('Diferencia presión persona [Pa]:')
disp(D_p)

