M1 =  0.30;
p1 = 7160; %Pa
T1 = 273 - 56.5;

mu_0 =1.71e-5; 
T0 = 273;

mu=@(T)mu_0 *(T/T0)^.75;

mu1 = mu(T1)

a1 = 20.05*(T1)^.5

V1 = M1*a1
R = 287.3;
rho_1 = p1/(R * T1)

Re_1 = 2*M1*a1*rho_1/mu1
% datos modelo
T2 = 273+50
a2 = 20.05*T2^.5
p2 = 110000;
mu2 = mu(T2)

rho2 =  p2/(R * T2)

V2_mach = M1*a2

V2_re = Re_1*mu2/(rho2*0.2)

%% problema 3


