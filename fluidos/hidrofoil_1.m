%% resistencia de tabla de widsurf
g = 9.80665;
% datos agua dulce a 20º
mu      = 1.009e-3;
rho     = 998.2;
nu      = mu/rho;

% datos tabla 
long    = 2;
b       = 0.6;
S_wet   = long*b;

% reynolds f(velocidad)
Re=@(V) V * long/nu;

CD_f=@(Re)0.455/(log10(Re)^2.58)-1610/Re;

V = 3;
Re_1 = Re(V);
CD_1 = CD_f(Re_1);

D_surf = rho/2 * V^2*CD_1*S_wet;

%% calculos del hydrofoil
% c_r = 0.3; c_t = 0.15; b = 0.8825;
lambda = 0.7
% S_w = c_r*b/2*(lambda+1)
% W = 100*g;
% 
% CL = W /(rho*0.5*S_w*V^2)
CL = 0.3
S_w = W /(rho*0.5*CL*V^2)
b = 0.9
% c_r = 2*S_w/((1+lambda)*b)
c_r = 0.4;
S_w = c_r*b/2*(lambda+1)

CL = W /(rho*0.5*S_w*V^2)
