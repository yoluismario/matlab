% problema 1
rho=1.225; D = 0.75; V = 12.5; g =9.80665;
A = pi*D^2/4
q_m = rho*A*V
V_max = 3*q_m/(2*pi*rho*(D/2)^2)
p1 = 0.03*g*1000;
p2 = 0.015*g*1000

R_X = A*(p2-p1)-V *q_m+2*pi*rho*V_max^2*(D/2)/4


% problema 2
V2 = sqrt((2*g*0.08*(13550-1000))/((1-0.6^4)*1000))
q = V2*pi*0.06^2/4
