function Res=theta_eq(K,theq, P)

Res(1)=K(1,1)*theq(1)+K(1,2)*theq(2)-P*sin(theq(1));
Res(2)=K(2,1)*theq(1)+K(2,2)*theq(2)-P*sin(theq(2));