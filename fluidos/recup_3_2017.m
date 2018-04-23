% Ejercicio 3
g = 9.80665;
Q = 0.8/60;
rho = 998; mu = 1.009E-3;
L = 290*0.3048;
D = 0.07;
A = pi*D^2/4;
rug = 0.152E-3;
V = Q/A
eta = 0.6;
f = f_SJ(Q/A,mu/rho,D,rug)
p1 = 20*6894.76;
Dh = 44*0.3048;

h_prim = f*L/D*V^2/(2*g)
% perdidas secundarias: valv globo (L/D =340) + 2 valv compuertas (L/D = 8+ 
% entrada borde recto (K = 0.5) + 7 codos (L/D = 30) 
h_secun = (7*30+ 340 + 2*8)*f*V^2/(2*g)+ 0.5*V^2/(2*g)

Dp = - p1 + (h_prim +h_secun) * rho * g + rho*g*Dh
Pot = Q*Dp/eta
Pot_HP = Pot/745.7

% ejercicio 2
clear
U0 = 20;
x = 5;
mu = 1.74E-5; rho =1.225;
b = 0.3;
Re_U =@(Ue) Ue*x*rho/mu;
delta =@(Re) 0.37*x/Re^(1/5);
delta1 =@(delta)delta/8;
Um =@(delta1) b^2*20/(b-delta1)^2;

Ue = U0
count = 5

for i=1:count
    Re  = Re_U(Ue)
    d   = delta(Re)
    d1  = delta1(d)
    Ue  = Um (d1)
end

Dp = rho/2*(Ue^2-U0^2)