%% Programa para simulacion de inesabilidad estatica y dinamica para una columna
%con dos masas y dos resortes torsionales

nolin=1; %flag para activar el modelo no lineal
seg=1; %flag para activar si la fuerza es seguidora

n1=[1 0 0]; n2=[0 1 0]; n3=[0 0 1];%

a1=@(th) n1*cos(th)+n2*sin(th);

P=1;
m=[1 2];
c=[0.01 0.001];%amortiguamientos
k=[2000 3500];
l=[10 15]; % longitudes barras

%vector de cond iniciales (theta_1, theta2, dot_theta1, dot_theta_2)
IC=[5*pi/180;-2*pi/180;0;0]; 

if nolin==0
    m1=m(1); m2=m(2); l1=l(1); l2=l(2); k1=k(1); k2=k(2);c1=c(1); c2=c(2);
    M=[(m1+m2)*l1^2,m2*l1*l2;m2*l1*l2, m2*l2^2];%matriz de masa
    K=[k1+k2 -k2;-k2 k2];
    C=[(c1+c2)*l1 c2*l1*l2; c2*l1*l2 c2*l2^2];
    if seg==1
    Kg=P*[-l1 l1;0 0];
    else
    Kg=P*[l1 l1;l2 l2];    
    end
    
    [t,X]=ode45(@(t,X) columna_lin(t,X,M,C,K,Kg), [0 100],IC);
else
     k1=k(1); k2=k(2);
     K=[k1+k2 -k2;-k2 k2];
    [t,X]=ode45(@(t,X) columna_nolin(t,X,m,c,l,K,P, seg), [0 100],IC);
    
end

theta_1=X(:,1); theta_2=X(:,2); dot_theta_1=X(:,3); dot_theta_2=X(:,4);

%%
figure(1)
subplot(2,2,1)
plot(t, theta_1)
subplot(2,2,3)
plot(t, dot_theta_1)
subplot(2,2,[2 4])
plot(theta_1, dot_theta_1);

figure(2)
subplot(2,2,1)
plot(t, theta_2)
subplot(2,2,3)
plot(t, dot_theta_2)
subplot(2,2,[2 4])
plot(theta_2, dot_theta_2);
