clc 
g=9.8065;
%% ejercico 62
format longG
D           =   0.004;
A           =   0.2*0.4;
Q           =   0.5;
mu          =   1.78E-5;
rho         =   1.225;
rug         =   0.05E-3;
L           =   0.6;


U   = Q/A
nu  = mu/ rho;
n_tubitos = A/f_area_circ(D)
Re  = U*rho*D/mu
f   = 64/Re

 L_ent  = 0.06 *Re*D
 h_L    = f*U^2*(L+L_ent)/(2*g*D)

% H_L_tot     = h_prim + h_secun
