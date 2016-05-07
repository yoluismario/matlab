V0=10;
% R=input('Resistencia R: ');
R =.1;
% C=input('Capacidad C: ');
C =2;
% tf=input('tiempo final, tf: ');
tf=10;

f=@(t,x) V0/R-x/(R*C); 

tspan = linspace(0,tf);
% tspan=[0 tf]; 
x0=0;
[t,x]=ode45(f,tspan,x0); 
plot(t,x,'r')
xlabel('t')
ylabel('q');
title('carga del condensador')

% a=input('parametro a: ');
% b=input('parametro b: ');
% %condiciones iniciales en el vector x0
% x0=zeros(1,2);
% x0(1)=input('valor inicial de x: ');
% x0(2)=input('valor inicial de y: ');
% tf=input('tiempo final, tf: ');
% 
% tspan=[0 tf]; 
% fg=@(t,x) [-a*x(1);a*x(1)-b*x(2)];
% [t,x]=ode45(fg,tspan,x0);
% 
% plot(t,x)
% xlabel('t')
% ylabel('x,y');
% title('dx/dt=-ax, dy/dt=ax-by')