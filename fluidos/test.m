% problema 52
e = 0.0095;
l = 0.61;
b = 0.3;
rho_agua = 998;
rho_plas = 1500;
nu_agua = 1.007e-6;
Vol = e * l *b;
S = 2*l*b;
g = 9.80665;

V=@(CD)sqrt(2*Vol*g/S*(rho_plas/rho_agua-1)/CD);

Re=@(V) V * l/nu_agua;

CD1=@(Re)0.074/Re^.2-1740/Re;
CD2=@(Re)0.455/(log10(Re)^2.58)-1610/Re;

CD0 = 1.328/sqrt(1000);
for i=1:9
	Veloc(i) = V(CD0);
	Rey(i) = Re(Veloc(i));
 %  CD0 = CD1(Rey(i));
	CD0 = CD2(Rey(i));
	CDy(i)=CD0;
end
disp('----------Problema 52---------------:')
disp('Reynolds:')
disp(Rey(end))
disp('Velocidad:')
disp(Veloc(end))
X_tr = 500000*nu_agua/(Veloc(end));
disp('transicion:')
disp(X_tr)
disp('porcentaje')
disp(X_tr/l*100)

%% problema 53
disp('----------Problema 53---------------')
l =107; d = 11; S_esf = 4*pi*(d/2)^2;
V = 27*1.852/3.6;
Re_l = l * V /nu_agua
CD_f = CD2(Re_l)
S_wet = pi*d*(1+(l-d)/2)
Pot = V^3 * rho_agua/2*S_wet*CD_f

%% problema 54
disp('----------Problema 54---------------')
d = 0.04; V = 0.4; 
S_m = pi*d^2/4; 
Re_d = d * V /nu_agua
CD_esf = 0.5;
Vol = 4/3*pi*(d/2)^3;

rho_x = (2*Vol*g/S_m+V^2*CD_esf)*(S_m*rho_agua)/(2*Vol*g)

%% problema 55
disp('----------Problema 55---------------')
mu_g = 1; rho_g = 1260; d = 0.005; rho_acero = 7830;Re=1;
%Vc = mu_g/(rho_g*d)
CD_esf = 24/Re
S_m = pi*d^2/4; 
Vc=sqrt(2*Vol*g/S_m*(rho_acero/rho_g-1)/CD_esf)






