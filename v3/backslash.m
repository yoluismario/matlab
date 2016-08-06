%problema de los dos carritos

m1=1; m2=2; c1=.0; c2=0.0; k1=2; k2=1;
 M=[m1 0;0 m2]; C=[c1+c2 -c2;-c2 c2]; K=[k1+k2 -k2;-k2 k2];
 
 A=[zeros(2), eye(2); -M^-1*K -M^-1*C];
 [ eigenv,lambda]=eig(A);
 IC=[1,1,0,0];
 [t,X]=ode45(@(t,X) carrito(t,X,A), [0 10],IC);
 
 figure(1)
subplot(2,2,1)
plot(t, X(:,1))
subplot(2,2,3)
plot(t, X(:,3))
subplot(2,2,[2 4])
plot(X(:,1), X(:,3));

 figure(2)
subplot(2,2,1)
plot(t, X(:,2))
subplot(2,2,3)
plot(t, X(:,4))
subplot(2,2,[2 4])
plot(X(:,2), X(:,4));
