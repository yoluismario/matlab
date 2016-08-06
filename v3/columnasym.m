syms k1 k2 l1 l2 m1 m2 P

K=[k1+k2, -k2; -k2,k2]
Kg=[l1 0;0 l2]


M=[(m1+m2)*l1^2, m2*l1*l2;m2*l1*l2, m2*l2^2 ]
invM=M^-1
A1=sym(zeros(2)); A2=sym(eye(2));
A=[A1, A2; invM*(K-P*Kg), A1]


[Lambda, V]=eig(A)
lambda1=simplify(Lambda(1,1))