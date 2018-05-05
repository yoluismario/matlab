% # Ejercicio teórico 1
a   = 450
b   = 600
E   = 210000;
nu  = 0.3;
h   = 1;
D   = E * h^3/(12*(1-nu^2));
f_K =@(m) (m/(a/b)+(a/b)/m)^2;


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
% Todos los casos tienen los 4 bordes apoyados.
E   = 77000;
nu  =  0.34;
h   = 1.2;
D   = E * h^3/(12*(1-nu^2));
% caso a) placa cargada de ambos lados
% RECORDAR: lado largo (a)?P_2 , lado corto (b)?P_1
a   = 800
b   = 600
P_1 = 1
P_2 = 0.6 % 0.6 P
R   = P_2*b/(P_1*a)

% funcion que define K 2lados
f_K_2lados =@(a,b,R,m,n) ((m*b/a)^2+n^2)^2 / ( (m*b/a)^2 +R*n^2)

K_2a = f_K_2lados(a,b,R,1,1)

P_crit_2a = K_2a *pi^2*D/b
% caso b) 
a   = 300
b   = 600
P_1 = 1 % 3*P 
P_2 = 3 % P
R   = P_2*b/(P_1*a)
K_2b = f_K_2lados(a,b,R,1,2)

P_crit_2b = K_2b *pi^2*D/b
% caso c) 
a   = 800;   b   = 200;
P_1 = 1;
P_2 = 0.6; % 0.6 P
R   = P_2*b/(P_1*a)

formatSpec = 'Con m =%2.0f ; n = %2.0f: K = %4.2f\n';
for m=1:3
    for n=1:3
        K = f_K_2lados(a,b,R,m,n);
        mat_K(m,n) = K;
        fprintf(formatSpec,m,n,K)
    end
end

K_2c = mat_K(3,1)
P_crit_2c = K_2c *pi^2*D/b

%% Ejercicio 3
% La placa del croquis de 640 por 320 mm tiene refuerzos cada 80mm en la
% dirección mas larga. Los refuerzos tienen 2 mm d eancho y 8 mm de alto.
% La placa tiene h = 8mm
clear
E = 75000; nu = 0.35;
h = 8; I_ref = 2*8^3/12
D   = E * h^3/(12*(1-nu^2));
G = E/(2*(1+nu))
a = 640; b= 320;


I_1 = I_ref; J_R1 = 8*2^3/3; d_1 = 80;
%refuerzo 2
J_R2 = 0; d_2 = 0.0001



C_44 = D + E* I_1/d_1;
C_55 = D + 0;
C_45 = nu*D;
C_66 = (1-nu)*D+0.5*G*(J_R1/d_1)

f_P =@(m) (pi^2*b/a^2*C_44)*m^2+(pi^2*a^5/b^3*C_55)/m^2+(2*pi^2/b)*(C_45+C_66)

