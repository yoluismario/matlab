A = [82 -24 0;-24 68 0;0 0 -20];
I_3 = det(A) % diagonales de un lado menos las otras
p = [1 -130 2000 100000]
tensiones = roots(p)

% TP 4 placas 
k2 = 6; k3 = 7.11; k1= 23; k4 = 1.18;
q_L = k2/(k3*k4)*(162^2)/210000;

W_0     = k1*k4/(k2*k3);
delta   = 1/k1;
beta    = k3/k1;

CS_cargas = 3.03;
CS_tensiones = 3.45;

