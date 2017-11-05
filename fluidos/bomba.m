%características de la tubería
D=35e-3 ; rug=0.002e-3; L=7;
deltaz=5;
%propiedades del fluido
dens=820; mu=2e-3;
%pérdidas secundarias
Kent=0.5; Ksal=1;
L_Dcodo=30; L_Dvalv=8;

A=pi*D^2/4;
%función del caudal volumétrico
Q= @(Vx) x*A;
%función de la altura mecánica generada por la bomba
h_bomba=@(x) 21.65-0.0833*x^2*A^2*1000;
%número de reynolds
Re=@(x) dens*x*D/mu;
f=@(x) 0.25/(log10(rug/D/3.7+5.74/(dens*x*D/mu)^0.9))^2;

tol=1e-3;
iter=0;
dif=1;
V1=5;
while  dif>tol
    
    Rey=Re(V1);
    f1=f(V1);
    h_b=V1^2/2/9.81*(f1*(L/D+2*L_Dcodo+ L_Dvalv)+Kent+Ksal)+deltaz;
    V2=h_b/0.0833/A/1e3;
    dif=V2-V1;
    V1=V2;
    iter=iter+1
    if iter>100 disp 'no converge!!'
        break
    end
end