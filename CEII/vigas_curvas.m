% vigas curvas
% %% teorico 1
% disp('--------- Ejercicio Teorico 1 -----------')
% a = 6; b1 = 8; b2 = 2; c = 18;
% sigma_f = 2800;
% A = (b1+b2)/2*(c-a)
% Am = (b1*c-b2*a)/(c-a)*log(c/a)-b1+b2
% R = (a*(2*b1+b2)+c*(b1+2*b2))/(3*(b1+b2))
% 
% sigma_r=@(N,M,r)N/A+M/(R*Am-A)*(1/r-Am/A);
% 
% s_r= sigma_r(6000,6000*R,6) 
% CS = sigma_f/s_r
% 
% %% teorico 3
% disp('--------- Ejercicio Teorico 3 -----------')
w1 =.3; b2 = 0.6; 
l1 = 1.3; r1 = 3.7 +w1/2;
nu = 0.3; l2 = 0.7;
t1 = 0.6;
% correccion de Bleich
lambda1=(3*(1-nu^2)/(r1^2*w1^2))^.25;
z1=2*lambda1*l1;
alfa=@(z) 1/(lambda1*l1)*(sinh(z)+sin(z))/(2+cosh(z)+cos(z));
beta=@(z) sqrt(3)*(cosh(z)-cos(z))/(2+cosh(z)+cos(z));
alfa1=alfa(z1)
beta1=beta(z1)

b1_prima = 2*(alfa1*l1)+t1

A1=b1_prima*w1
R1=(3.7+4)/2
Am1 = b1_prima*log(4/3.7)
% seccion 2
A2 = b2*l2
R2 = (3+(3+l2))/2
Am2 = b2*log((3+l2)/3)
% seccion equivalente
Am = Am1+Am2
A = A1 + A2
R = (R1*A1+R2*A2)/A

%z = l1^2/(r1*w1)
S_theta=@(P,r)P/2/A+(P/2*3.9)/(R*Am -A)*(1/r-Am/A);
s1=S_theta(1,4)
s2=S_theta(1,3.85)
s3=S_theta(1,3)
S_z = -beta1*s1
S1comp = sqrt(S_z^2+s1^2-S_z*s1)

S2comp = sqrt(s3^2)

% ejercicios teóricos del apunte
% a = 6; b1 = 8; b2 = 2; c = 18;
% A = (b1+b2)/2*(c-a)
% Am = (b1*c-b2*a)/(c-a)*log(c/a)-b1+b2
% R = (a*(2*b1+b2)+c*(b1+2*b2))/(3*(b1+b2))
% 
% sigma_r=@(N,M,r)N/A+M/(R*Am-A)*(1/r-Am/A);
% 
% s_r= sigma_r(6000,6000*R,6) 

%% practico
l =  1.3;
r = 3.85;
alfa = 0.6;
