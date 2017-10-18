%% Parcial 1 
% Resolución de los ejercicios del primer parcial
% 

clear
%% Ejercicio 1 Embrague hidraulico
% * Diferencial de superficie:
%
% $$ dS = 2 .\pi .r .dr $$
%
% * Diferencial de fuerza tangencial:
% 
% $$ dF_t = \tau . dS $$
% 
% * Diferencial de momento:
% 
% $$ dM_t = r . dF_t $$
% 
% * Equivalencia de potencia:
%
% $$ Pot = M_t.\omega_2 $$
%
% * Tensión tangencial por ser fluido newtoniano: 
% 
% $$ \tau = \mu . \frac{du}{dn} = \mu \frac{(\omega_1 -\omega_2)}{a}$$
%
% * Momento:
% 
% $$ M_t =2 .\pi . \mu \frac{(\omega_1 -\omega_2)}{a} \int_0^{(D/2)} r^3 dr $$
%
% * Despejando de la anterior y reemplazando el $$ M_t $$:
% 
% $$ a = \frac{\pi.\mu}{4.Pot} (\omega_1 -\omega_2) (D/2)^4 = 0.1987 [m]$$


w1 = 10000/60*2*pi;
w2 = 9000/60*2*pi;
D = 0.45;

mu = 0.01;
P = 20;%w2*T
a = mu*pi*(w1-w2)*D^4/(32*P/w2); %[m]


%% Ejercicio 2 Cono
% La superficie externa del cono está sometida al efectode chorro de agua, 
% además la presión alrededor es siempre igual a $$ P_{amb} $$.
% La fuerza que hace el resorte va en sentido de opuesto a la dirección del
% fluido, suponiendo el eje *x* positivo hacia la derecha, la fuerza del
% resorte tiene signo negativo:
%
% $$ -F_{resorte} = \int_{SC} \rho.u.\vec{V} . \hat{n} dA$$
%
% * Como la magnitud de la velocidad es la misma a la entrada que a la
% salida, aplicando conservación de la masa, las áreas son equivalentes:
%
% $$ A_1 = \frac{\pi D^2}{4} = 2.\pi R.h = A_2 $$
%
% * Realizando las dos integrales, resulta: 
%
% $$ -F_{resorte} = \rho.U(-U).\left( \frac{\pi D^2}{4}\right) + \rho(U \cos(\alpha)).U.\left( \frac{\pi D^2}{4}\right) $$
%
% * Finalmente la deflexión del resorte es: 
% 
% $$ \Delta x = \frac{\rho.\pi D^2 (1-\cos(\alpha)) U^2}{4.k} = 0.0102 [m] $$

clear
V = 20;
D = 0.12;
R = 0.3;
h = D^2/(8*R);
alfa = 35;
rho = 998;
Feq = rho*V^2*(pi*D^2/4)*(1-cosd(alfa))
k = 80000;
dx = Feq/k

%% Ejercicio 3 Conducto rectangular
% El problema es simplemente conservación de la masa y en función de la 
% definición de caudal, resolver la velocidad media a la salida.
% 
% $$ Q_{sup} (x) =  1.3580\cdot x^2 $$
%
% $$ Q_{lat} (x) = 130 - 14.444\cdot x $$
% 
% $$ Q_{salida} = Q_0 + \int_0^{9} 1.3580\cdot x^2\ dx -\int_0^{9}(130-14.444\cdot x) dx $$
%
% $$ \bar{U} = \frac{Q_{salida}}{A} = 0.375 [m/s] $$

clear;
syms x;
l = 9; A = 12;
Q0 = 300;
Qe = (110/l^2)*x^2;
Qs = 130 - (130/l)*x;

Vm = (Q0 + int(Qe,x,0,l) - int(Qs,x,0,l))/(10*A) % en [m/s]
