%% Problemas de flujo interno
clc 
g=9.8065;

%% Problema 68 
% Ventilador de una mina.
% Encontrar el incremento de presión que debe producir el ventilador.
% 
% *Recuerden:*
% 
% * que deben considerar la presión a la salida como _Pamb_ más la
% presión de columna de fluido, en este caso aire.
% * el punto inicial para plantear la ecuación de la energía está ubicado 
% por fuera del _bell mouth_.
%
% Datos:
h= 700; rho = 1.225;D = 0.5;mu = 1.78E-5;
L = 700 + 20; K = 3.5; L_cod = 12; eta = .75;
p1=0; p2=rho*g*h;z1=0;z2=700;Q=120/60;%m3/seg
A=pi*D^2/4; 
V=Q/A;
nu = mu/rho;
epsilon=0.15E-3; % chapa galvanizada
Re=V*D/nu;
% factor de fricción
 f=f_SJ(V,mu/rho,D,epsilon);
%%
% $$ h_{bomba}= \frac{V^2}{(2*g)}\left[1+\frac{f}{D}(L + 2 L_{cod})+K)\right]$$

h_bomba= V^2/(2*g)*(1+(L + 2*L_cod)*f/D+K);
Dp_bom = h_bomba*rho*g
P_bom = h_bomba*rho*g*Q/eta
P_bom_hp = P_bom/745.7

%%
% los resultados de $\Delta p_{bomba}$ y la potencia son similares 
% a la guia de ejercicios

%% Problema 69 
% Ducto de ventilación, determinar la potencia del ventilador según:
%
% # Sección de conducto circular
% # Sección de conducto rectangular
clear
rho = 1.225;D = 0.32;mu = 1.78E-5; nu = mu/rho;
rhoH2O = 1000; hH2O = .01;
L = 100; eta = .5; g=9.8065;
p1=0; p2=rhoH2O*g*hH2O
Q = 0.8;%m3/seg
%%     
% opcion 1)
    A=pi*D^2/4; V = Q/A;
    epsilon=0.15E-3;% chapa galvanizada
    Re=V*D/nu;
    % factor de friccion
    f=f_SJ(V,mu/rho,D,epsilon);
    h_l = f*L/D*V^2/2
    h_bomba= p2/(rho*g)+V^2/(2*g)*(1+f*L/D);
    Dp_bom = h_bomba*rho*g;
    P_bom = h_bomba*rho*g*Q/eta
    P_bom_hp = P_bom/745.7
    
%%
% opcion 2)
% El diámetro hidráulico se despeja de hacer iguales las áreas,
%
% _D_e_ es el efectivo
    D_h = 4/3*D*sqrt(pi/8)
    D_e = 0.65 * D_h
    % factor de friccion
    f=f_SJ(V,mu/rho,D_e,epsilon);
    h_l = f*L/D_h*V^2/2
    h_bomba= p2/(rho*g)+V^2/(2*g)*(1+f*L/D_h);
    Dp_bom = h_bomba*rho*g;
    P_bom = h_bomba*rho*g*Q/eta
    P_bom_hp = P_bom/745.7
%%
% Para los problemas este resultado es más preciso.
%
% *El resultado de la guia de ejercicios está calculado sin usar la
% corrección de Jones.*

