% calcula el vector RHS, en funcion de las velocidades y
% las normales
function [RHS]=vectRHS(VelN,normN)
aux = kron(ones(size(normN,2),1),VelN);
auxRHS =dot(aux',normN);
% sumarFila(1:end-1)= A;
RHS = auxRHS';