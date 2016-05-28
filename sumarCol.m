function [s]=sumarCol(A)
sumarCol=ones(size(A)+1);
sumarCol(1:end-1,1:end-1)= A;
s = sumarCol;