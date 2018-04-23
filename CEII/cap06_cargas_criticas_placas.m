% # Ejercicio teórico 1
a   = 450
b   = 600
E   = 210000;
nu  = 0.3;
h   = 1;

f_K =@(m) (m/(a/b)+(a/b)/m)^2;
D   = E * h^3/(12*(1-nu^2));

K = f_K(1)
P_crit = K * pi^2*D /b
% ## b) Acotar la carga crítica suponiendo que los bordes están apoyados
% elásticamente en una situación intermedia entre apoyados y empotrados.
K = 12;
P_crit = K * pi^2*D /b

% ## c) Borde superior libre
K = 2.1;
P_crit = K * pi^2*D /b
 

%% Ejercicio 2
% 