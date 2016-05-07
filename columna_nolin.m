function dXdt=columna_nolin(t,X, m , c,l ,K,P,seg)
dXdt=zeros(4,1);
l1=l(1); l2=l(2); m1=m(1); m2=m(2); c1=c(1); c2=c(2);
theta_1=X(1); theta_2=X(2);


%matriz de masa:
M=zeros(2);
M(1,1)=(m1+m2)*l1^2; M(1,2)=m2*l1*l2*cos(theta_2-theta_1);
M(2,1)=M(1,2);       M(2,2)=m2*l2^2;
% matriz de amortiguamiento
C(1,1)=(c1+c2)*l1^2*cos(theta_1)^2;
C(1,2)=c2*l1*l2*cos(theta_1)*cos(theta_2);
C(2,1)=C(1,2);
C(2,2)=c2*l2^2*cos(theta_2)^2;

dXdt(1:2)= X(3:4);% integra eta 1 y eta 2 en t+1 con dot_eta1 y dot_eta2 en t

Finerc=[m2*l1*l2*X(4)^2*sin(theta_2-theta_1);m2*l1*l2*X(3)^2*sin(theta_2-theta_1)];

if seg==1
    Fext=P*[l(1)*sin(X(2)-X(1));0];
else
end
RHS=-C*X(3:4)-(K)*X(1:2)-Fext-Finerc;
dXdt(3:4)=RHS\M; %calcula dot_eta en t+1 con la suma de fuerzas 