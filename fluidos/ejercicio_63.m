clc 
g=9.8065;
%% ejercico 62
format longG
D           =   0.5;
A           =   f_area_circ(D);
Q           =   1.8;
mu          =   1.78E-5;
rho         =   1.225;
rug         =   0;
L           =   0.4;


U   = Q/A
nu  = mu/ rho;

Re  = U*rho*D/mu


f   = f_SJ(U,nu,D,rug)

%  L_ent  = 0.06 *Re*D
%  h_L    = f*U^2*(L+L_ent)/(2*g*D)

% H_L_tot     = h_prim + h_secun
