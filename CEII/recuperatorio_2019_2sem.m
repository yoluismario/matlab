%% Ejercicio de fatiga
% ejemplo 6.9 del libro de Shigley
Su = 690;
D   = 38;
d   = 32; %diámetro menor en punto B
r   = 3;  % radios menores de cambios de seccion
F_1 = 3500; % fuerza en el inciso a)
F_2 = F_1/2; % fuerza inciso b)
CS  = 2;

Se_p=0.5*Su;

% maquinado
f_s = 4.51/(Su)^.265;
% factor de tamaño
f_T = 1.24*32^-.107;

% tipo de carga: flexión = 1
f_c = 1; 

% Límite de fatiga de la pieza
Se = f_s*f_T*f_c*Se_p;

% calculo del factor de concentración de tensiones en fatiga
r_rho=@(x)1.24-0.00225*x+1.6E-6*x^2-4.1E-10*x^3;
r_rho(Su);

q = 1/(1+r_rho(Su)/sqrt(3));

r/d;
D/d;
Kt =1.65;

K_f = 1 + q *(Kt-1);
% necesitamos calcular el esfuerzo flector
R1 = 225/550*F_1; % en Newtons
Mf_B = R1*250; % en N.mm
sigma_B = Mf_B*32/(pi*d^3); % en MPa

SN = CS*K_f*sigma_B; % en MPa

% determinar la vida en fatiga de la pieza
a = (0.9*Su)^2/Se;
b = 1/3*log10(0.9*Su/Se);
c = 1/b;

N = (a/SN)^c;
N1 = N; SN1 = SN;

%% inciso b) 
% la carga disminuye a la mitad, debe calcularse nuevamente el SN, con este
% elegir qué metodo vamos a usar para la vida remanente, Miner o Manson
R1 = 225/550*F_2; % en Newtons
Mf_B = R1*250; % en N.mm
sigma_B = Mf_B*32/(pi*d^3); % en MPa

SN2 = CS*K_f*sigma_B; % en MPa

% Si eligen Miner, la vida será infinita lo cual es equivocado
% deben elegir Manson
n1 = 20000;
Nr_1 = N1 -n1;

b2 = log10(0.9*Su/SN1);
a2 = 0.9*Su*1000^b2;
c2 = 1/b2;

Se2 = a2/(10E6)^b2;

N2 = (a2/SN2)^c2

%% Ejercicio placas
S_adm = 120; %MPa
E     = 210000; nu = 0.3;
c = 1000; % mm
l = 2000; % mm
alfa = c/l;%

q = 0.0098*3

% caso 1: circular
K_1 = 85.333/((5+nu)*(1-nu))
K_2 = 6
K_3 = 8*(3+nu)/((5+nu)*(1-nu))
K_4 = 1.18

q_L = K_2*S_adm^2/(K_3 *K_4*E)

A = pi*500^2/4
% % caso 7
% K_1 = 32*(1+alfa^4)/(1-nu^2)
% K_2 = 22 + 17.6*alfa^4
% K_3 = 8.8 + 1.2*alfa^3
% K_4 = 1.8

