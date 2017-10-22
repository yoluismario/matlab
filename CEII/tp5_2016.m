
% CE II - TP5 MEF
%% ejercicio 1
% segun formula (6) calculamos los a_ij
u_11= 0.02;u_21=0.03;u_31=0.03;
u_12=-.04; u_22=0.04; u_32=-0.01;
a_11=0;a_12= -70;a_21 =40; a_32=70; a_22=0; a_31=40;
%% Deformaciones 
A = 0.5*(a_21*a_32-a_22*a_31);
Eps_11=-(u_11*a_12+u_21*a_22+u_31*a_32)/(2*A);
Eps_22=(u_12*a_11+u_22*a_21+u_32*a_31)/(2*A);
Eps_12=((u_11*a_11+u_21*a_21+u_31*a_31)-(u_12*a_12+u_22*a_22+u_32*a_32))...
    /(4*A);
%% Tensiones
alfa= 2100000/(1-0.3^2);
M_x = [1 .3 0; .3 1 0; 0 0 .7];
vect_eps = [Eps_11; Eps_22; Eps_12];
tens=alfa*M_x*vect_eps;
disp('Ejercicio 1:')
von_mises =(tens(1)^2+tens(2)^2-tens(1)*tens(2)+3*tens(3)^2)^.5
C_s=2100/von_mises

%% ejercicio 2
disp('Ejercicio 2:');
nu=0.3;t=0.2;E=2100000;
H=120; W=100;l_ten=sqrt(H^2+W^2);
cos1=-W/l_ten; cos2=H/l_ten;
% definiciones
a_11=-100;a_12=-120;a_21 =100; a_32=120; a_22=0; a_31=0;
A_2 = 0.5*(a_21*a_32-a_22*a_31);
alfa_2=E*t/(4*A_2*(1-nu^2));
beta=(1-nu)*0.5;
% Matriz de rigidez
k11_11=alfa_2*(a_12^2+beta*a_11^2);
k22_11=alfa_2*(a_11^2+beta*a_12^2);
k12_11=-alfa_2*(a_12*a_11*nu+beta*a_11*a_12);
K = [k11_11 k12_11;k12_11 k22_11];
%vector cargas
  P = [0; (-40*120)/2-(200*100)/2-5000];
%desplazamientos
  desp=K\P;
% deformaciones
u_11=desp(1); u_21=desp(2);
  Eps_11=-(u_11*a_12+u_21*a_22+u_31*a_32)/(2*A_2);
  Eps_22=(u_12*a_11+u_22*a_21+u_32*a_31)/(2*A_2);
  Eps_12=((u_11*a_11+u_21*a_21+u_31*a_31)-(u_12*a_12+u_22*a_22+u_32*a_32))...
    /(4*A_2);
      
%tensiones
  vect_eps = [Eps_11; Eps_22; Eps_12];
  tens_2=alfa*M_x*vect_eps;
  von_mises_2=(tens_2(1)^2+tens_2(2)^2-tens_2(1)*tens_2(2)+3*tens_2(3)^2)^.5;
  C_s=2100/von_mises_2;
% tensor 

A_T =20
K_T = A_T*E/l_ten;
K_new = [k11_11+K_T*cos1^2 k12_11-K_T*cos1*cos2;k12_11-K_T*cos1*cos2 ...
      k22_11+K_T*cos2^2];
desp_new=K_new\P;  
disp('Desplazamiento nudo 1')
dif= desp_new(2)/desp(2)
  