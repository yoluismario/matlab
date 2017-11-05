%% resuelve la ecuación de flujo incompresible interno en conductos 
%conocidas la presión y altura a la entrada
tic
rug=0; D=0.1; nu=1.1385e-6; rho=999.1; g=9.81; L=50;
% datos de entrada
%
p1=80e3; p2=243.4e3; %[Pa]
z1=25; z2=0; %[m]
hbomba=0;
%asume velocidad en dirección de 1 hacia 2

hf=(p1-p2)/rho/g+z1-z2+hbomba;


%% formula original de colebrook
f0=0.1; %guess inicial para el factor de fricción
V0=20; %guess inicial para V
tol=1e-3; dif_f=1; 
while (dif_f >=tol)
    
fun1=@(V) colebrookV(V, hf, f0, g, nu,L, D, rug); 
V1=fzero(fun1, V0);%, options); 
f1=fzero( @(f) colebrookf(f,V1,  nu, D, rug),f0);%, options);
dif_f=abs(f1-f0);
V0=V1; f0=f1;

end

%% fórmula simplificada de Swamie y Jann
dif_V=1;
while (dif_V >=tol)
V2=fzero( @(V) Swamie_Jain(V,  hf, g, nu,L, D, rug),V0);%, options);
dif_V=abs(V2-V0);
V0=V2; 
end
toc