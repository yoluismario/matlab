% siguiendo "combining the models" capitulo 4 de preidikman
% vamos a definir las funciones que usamos para resolver la ecuacion de
% movimiento

% F0= F(y_0) F0 es el valor de la condición inicial 
% los primeros pasos de la solución son predecidos de manera diferente a la
% los pasos prosteriores


y0 = [1 ; 1]; Dt=1;
F0 = [0.2; 0.1];
F=@(x)x*1.05;
% 1
% Euler Method
p1_EM=y0+Dt * F0;

% 2
% MOdified Euler Method
while e<tol
    kF1=F(p1_EM);
    kM1y1=y0+(Dt/2)*(kF1+F0);
    e=norm(kM1y1,ky1);
end
