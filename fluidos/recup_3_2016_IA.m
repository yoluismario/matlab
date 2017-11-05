clear
clc
Q = 0.8/60;%0.439*0.3048^3
D = 0.07; %2.469*0.0254
A = pi*D^2/4
g=9.81;
V = Q/A
p1 = 20*6894.76% /14.7*98066
L = 290*0.3048
L_v = 8; L_glo = 340;L_cod = 30; K = 0.5;
eps = 0.152e-3
rho = 998; mu = 1.003e-3;
nu = mu/rho; 
Dz = -44*0.3048
Re=V*D/nu
eta =0.6;
f = 0.25/(log10((eps/D)/3.7+5.74/Re^.9))^2

h_prim =V^2/(2*g)*f*L/D
h_sec = V^2/(2*g)*(f*(2*L_v+L_glo+7*L_cod)+K)
h_l = V^2/(2*g)*(f*(L/D+2*L_v+L_glo+7*L_cod));

h_ent = K * V^2/(2*g);

h_tot = h_l +h_ent

h_bomba = p1/(rho*g)+Dz+h_tot

Dp_bomba = h_bomba*rho*g

P_bom = h_bomba*rho*g*Q/eta
P_bom_hp = P_bom/745.7

%% problema 1
clear
disp('problema 1:')
V = 10*1.852/3.6
 rho = 1000; 
L= 360;B = 70;C =25;
rho = 1000; mu = 1.307e-3;
nu = mu/rho ;
Re = V*L/nu

C_D = 0.455/(log10(Re))^(2.58)-1610/Re
A = B*C*2+L*C*2+B*L

FD = C_D * A *rho/2*V^2

 Pot =FD*V
 