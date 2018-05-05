function tp_2_2017()
P = input('Ingresar P= ');

P1 = P; P2 = 2*P; P3 = 3/2*P;
    formatSpec = 'Cargas: P1 =%4.2f, P2 = %6.3f, P3 = %4.2f.\n';
    fprintf(formatSpec,P1,P2,P3)
pext = [P2 -P1 0];
pint = [0 0 P3];
vec1 = [160 95 -80];
vec2 = [160 0 0];

N = P2;
M1 = cross(vec1,pext);
M2 = cross(vec2,pint);
Mtot = M1+M2
alfa = atand(Mtot(2)/Mtot(3));

d_e = 19;
I = pi/64*(d_e^4-18^4);
A = pi/4*(d_e^2-18^2);
Ip = I*2;
fprintf('----------------------------------------\n')
%% 2)
M_T = Mtot(1); My = Mtot(2); Mz = Mtot(3);

% en B:
fprintf('2)   Punto B: \n');
sigma_B = N/A-Mz/I*d_e/2;
tau_B = M_T/Ip*d_e/2;
s_vm_B = sqrt(sigma_B^2+3*tau_B^2);
CS_vm_B =2800/s_vm_B;
    s_tresca_B = f_tresca_CS(0,sigma_B,tau_B);
CS_tresca_B = 2800/s_tresca_B;

fprintf('sigma_B = %4.2f, tau_B = %4.2f, sigma_comp_VM = %4.2f\n',sigma_B,tau_B,s_vm_B)
fprintf('CS VM_B = %4.2f, CS_tresca_B = %4.2f\n',CS_vm_B,CS_tresca_B)
fprintf('----------------------------------------\n')
% en A:
sigma_A = N/A+Mz/I*d_e/2;
tau_A = M_T/Ip*d_e/2;
s_vm_A = sqrt(sigma_A^2+3*tau_A^2);
CS_vm_A =2800/s_vm_A; 
    s_tresca_A = f_tresca_CS(0,sigma_A,tau_A);
CS_tresca_A = 2800/s_tresca_A;
fprintf('Punto A: \n');
fprintf('sigma_A = %4.2f, tau_A = %4.2f, sigma_comp_VM = %4.2f\n',sigma_A,tau_A,s_vm_A)
fprintf('CS VM_A = %4.2f, CS_tresca_A = %4.2f\n',CS_vm_A,CS_tresca_A)

%% 3)
fprintf('----------------------------------------\n')
% momento máximo compuesto por los Mz y My
M_max = sqrt(Mz^2+My^2);
sigma_D = N/A+M_max/I*d_e/2;
tau_D = M_T/Ip*d_e/2;
s_vm_D = sqrt(sigma_D^2+3*tau_D^2);
CS_vm_D =2800/s_vm_D;
    s_tresca_D = f_tresca_CS(0,sigma_D,tau_D);
CS_tresca_D = 2800/s_tresca_D;
fprintf('3) Punto más solicitado, D: \n');
fprintf('sigma_D = %4.2f, tau_D = %4.2f, sigma_comp_VM = %4.2f\n',sigma_D,tau_D,s_vm_D)
fprintf('CS VM = %4.2f, CS_tresca = %4.2f',CS_vm_D,CS_tresca_D)

fprintf(' \n')
fprintf('----------------------------------------\n')

%% 4) Sección maciza, CS = 3, P2 = 0
% nuevo cálculo de momentos:
fprintf('4) Seccion maciza: \n');
s_vm = 2800/3;
P2 = 0;
% volvemos a calcular
    pext = [P2 -P1 0];    pint = [0 0 P3];
    vec1 = [160 9.5 -80]; vec2 = [160 0 0];
    M1 = cross(vec1,pext);
    M2 = cross(vec2,pint);
    Mtot = M1+M2; My = Mtot(2); Mz = Mtot(3);
    M_max = sqrt(Mz^2+My^2);
% calculo del diametro
d_e =( ((32*M_max/pi)^2+3*(16*M_T/pi)^2)/s_vm^2)^(1/6);
I = pi/64*(d_e^4); A = pi/4*(d_e^2); Ip = I*2;

sigma = M_max/I*d_e/2;
tau = M_T/Ip*d_e/2;
s_vm = sqrt(sigma^2+3*tau^2);
CS_vm =2800/s_vm;

s_tresca  = f_tresca_CS(0,sigma,tau);
CS_tresca = 2800/s_tresca;

fprintf('Diámetro exterior = %4.4f [cm], CS tresca = %4.4f\n',d_e,CS_tresca)
fprintf(' \n')
fprintf('----------------------------------------\n')
%% 6) Sección maciza, CS = 2, P2 = ?
% nuevo cálculo de momentos:
fprintf('6) Encontrar valor de P: \n');
s_vm = 2800/2;
%P2 = A*(sqrt(s_vm^2-3*tau^2)-sigma_flex);
P = (s_vm*d_e^3*pi)/(32*sqrt(288.44^2+120^2));

% volvemos a calcular
    P1 = P; P3 = 3/2*P;
    pext = [0 -P1 0];    pint = [0 0 P3];
    %vec1 = [160 9.5 -80]; vec2 = [160 0 0];
    M1 = cross(vec1,pext);
    M2 = cross(vec2,pint);
    Mtot = M1+M2; My = Mtot(2); Mz = Mtot(3);
    M_max = sqrt(Mz^2+My^2);
% otro
sigma = M_max/I*d_e/2;
s_tresca  = f_tresca_CS(0,sigma,tau);
CS_tresca = 2800/s_tresca;

fprintf('P2 = %4.4f [kgf], CS tresca = %4.4f\n',P,CS_tresca)
fprintf(' \n')
fprintf('-------------------- fin --------------------\n');
end