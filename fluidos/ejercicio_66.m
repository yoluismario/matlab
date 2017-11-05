clc 
g=9.8065;
%% ejercico 66
format longG
D           =   0.4;
K_entrada   =   0.5;
Q           =   36/60;
mu          =   8E-3;
rho         =   860;
rug         =   0.05E-3;
K_salida    =   1;
K_globo     =   5.5;
LDeq        =   30;
L           =   100;
eta_bomba   =   0.8;

A = f_area_circ(D);
U = Q/A;
nu = mu/ rho;

Re = U*rho*D/mu
f = f_SJ(U,nu,D,rug)

h_prim      = f*U^2*L/(2*g*D)

h_secun     = (K_salida+3*K_globo+K_entrada)*U^2/(2*g) + 2*f*LDeq*U^2/(2*g)

H_L_tot     = h_prim + h_secun
format shortEng
Dp_bomba    = rho* g * (15+H_L_tot)

Pot_watt    = rho* g * Q * (15+H_L_tot)/eta_bomba
Pot_HP      = Pot_watt/745.7
