% vigas curvas
%% teorico 1
disp('--------- Ejercicio Teorico 1 -----------')
a = 6; b1 = 8; b2 = 2; c = 18;
sigma_f = 2800;
A = (b1+b2)/2*(c-a)
Am = (b1*c-b2*a)/(c-a)*log(c/a)-b1+b2
R = (a*(2*b1+b2)+c*(b1+2*b2))/(3*(b1+b2))

sigma_r=@(N,M,r)N/A+M/(R*Am-A)*(1/r-Am/A);

s_r= sigma_r(6000,6000*R,6) 
CS = sigma_f/s_r

%% teorico 3
disp('--------- Ejercicio Teorico 3 -----------')

% a = 6; b1 = 8; b2 = 2; c = 18;
% A = (b1+b2)/2*(c-a)
% Am = (b1*c-b2*a)/(c-a)*log(c/a)-b1+b2
% R = (a*(2*b1+b2)+c*(b1+2*b2))/(3*(b1+b2))
% 
% sigma_r=@(N,M,r)N/A+M/(R*Am-A)*(1/r-Am/A);
% 
% s_r= sigma_r(6000,6000*R,6) 