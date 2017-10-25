P = input('P= ');

P1 = P
P2 = 2*P
P3 = 3/2*P
pext = [P2 -P1 0];
pint = [0 0 P3];
vec1 = [160 9.5 -80];
vec2 = [160 0 0];

N = 2*P;
M1 = cross(vec1,pext);
M2 = cross(vec2,pint);
Mtot = M1+M2
alfa = atand(Mtot(2)/Mtot(3))

d_e = 19;
I = pi/64*(d_e^4-18^4);
A = pi/4*(d_e^2-18^2);
Ip = I*2;
% 2)
M_T = Mtot(1); My = Mtot(2); Mz = Mtot(3);
% en B:
sigma_B = N/A-Mz/I*d_e/2
tau_B = M_T/Ip*d_e/2
s_vm_B = sqrt(sigma_B^2+3*tau_B^2);
CS_vm_B =2800/s_vm_B 

    s_tresca_B = f_tresca_CS(0,sigma_B,tau_B);
CS_tresca_B = 2800/s_tresca_B
% en A:
sigma_A = N/A+Mz/I*d_e/2
tau_A = M_T/Ip*d_e/2
s_vm_A = sqrt(sigma_A^2+3*tau_A^2);
CS_vm_A =2800/s_vm_A 
    s_tresca_A = f_tresca_CS(0,sigma_A,tau_A);
CS_tresca_A = 2800/s_tresca_A