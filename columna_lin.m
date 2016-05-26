function dXdt=columna_lin(t,X,M,C,K,Kg)
dXdt=zeros(4,1);
dXdt(1:2)= X(3:4);
% integra eta 1 y eta 2 en t+1 con dot_eta1 y dot_eta2 en t


RHS=-C*X(3:4)-(K+Kg)*X(1:2);
% suma de fuerzas (amort +elasticas+externas)
%calculadas con eta y dot_eta en t
dXdt(3:4)=RHS\M;
%calcula dot_eta en t+1 con la suma de fuerzas 