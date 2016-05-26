function test_ode(odes)
%odes = 2

if odes==1;
	V0=10;
	% R=input('Resistencia R: ');
	R =.1;
	% C=input('Capacidad C: ');
	C =2;
	% tf=input('tiempo final, tf: ');
	tf=10;

	f=@(t,x) V0/R-x/(R*C); 
	tspan = linspace(0,tf,60);
	% tspan=[0 tf]; 
	x0=0;
	[t,x]=ode45(f,tspan,x0); 
	plot(t,x,'r')
	xlabel('t')
	ylabel('q');
	title('carga del condensador')
end

if odes==2;
   	% a=input('parametro a: ');
	% b=input('parametro b: ');
	a = 1; b=2;
	%condiciones iniciales en el vector x0
	x0=zeros(1,2);
	% x0(1)=input('valor inicial de x: ');
	x0(1)=2; x0(2)=0; w_0=8;
	gamma=0.1;% amortiguamiento
	% x0(2)=input('valor inicial de y: ');
	% tf=input('tiempo final, tf: ');
	tf=60;
	tspan=[0 tf]; 
	%fg=@(t,x) [-a*x(1);a*x(1)-b*x(2)];
	% [t,x]=ode45(fg,tspan,x0);

	fg=@(t,x)func_radioactivo(t,x,a,b);
	% [t,x]=ode45(fg,tspan,x0);
	fosc=@(t,x) [x(2);-2*gamma*x(2)-w_0^2*x(1)];
	[t,x]=ode45(fosc,tspan,x0);

	plot(t,x)
	xlabel('t')
	ylabel('x,y');
	title('dx/dt=-ax, dy/dt=ax-by')
end
if odes==3;
	%condiciones iniciales
	x0=zeros(1,4);
	x0(1)=input('posición inicial x: ');
	x0(2)=input('velocidad incial x: ');
	x0(3)=0;
	x0(4)=input('velocidad incial y: ');

	tf=input('tiempo final, tf: ');
	tspan=[0 tf];

	fg=@(t,x)[x(2);-4*pi*pi*x(1)/(sqrt(x(1)*x(1)+x(3)*x(3)))^3; x(4);
	-4*pi*pi*x(3)/(sqrt(x(1)*x(1)+x(3)*x(3)))^3];
	[t,x]=ode45(fg,tspan,x0);
	plot(x(:,1),x(:,3),'r')
	xlabel('x')
	ylabel('y');
	title('órbita de un planeta')
end
if odes==4;
	%condiciones iniciales
	n1=[1 0 0]; n2=[0 1 0]; n3=[0 0 1];%

	a1=@(th) n1*cos(th)+n2*sin(th);

	P=1;
	m=[1 2];
	c=[0.01 0.001];%amortiguamientos
	k=[2000 3500];
	l=[10 15]; % longitudes barras
	%vector de cond iniciales (theta_1, theta2, dot_theta1, dot_theta_2)
	x0=zeros(1,4);
	x0(1)=deg2rad(input('tita_1: '));
	x0(2)=input('tita_punto_1: ');
	x0(3)=deg2rad(input('tita_2: '));
	x0(4)=input('tita_punto_2: ');
	disp(x0);
	tf=input('tiempo final, tf: ');
	tspan = linspace(0,tf,100);%tspan=[0 tf];
	
	
	
	% definiciones de valores
     m1=m(1); m2=m(2); l1=l(1); l2=l(2);
	 k1=k(1); k2=k(2);c1=c(1); c2=c(2);
	%
	     M=[(m1+m2)*l1^2,m2*l1*l2;m2*l1*l2, m2*l2^2];%matriz de masa
	     K=[k1+k2 -k2;-k2 k2];
	%     C=[(c1+c2)*l1 c2*l1*l2; c2*l1*l2 c2*l2^2];
	%
	 Kg=P*[l1 l1;l2 l2];
	%
	fg=@(t,x)[x(2);...
	-4*pi*pi*x(1)/(sqrt(x(1)*x(1)+x(3)*x(3)))^3;...
	 x(4);...
	-4*pi*pi*x(3)/(sqrt(x(1)*x(1)+x(3)*x(3)))^3];
	[t,x]=ode45(fg,tspan,x0);
	
	
	%     [t,X]=ode45(@(t,X) columna_lin(t,X,M,C,K,Kg), [0 100],IC);
end
	% fg=@(t,x)[x(2);-4*pi*pi*x(1)/(sqrt(x(1)*x(1)+x(3)*x(3)))^3; x(4);
	% -4*pi*pi*x(3)/(sqrt(x(1)*x(1)+x(3)*x(3)))^3];
	% [t,x]=ode45(fg,tspan,x0);
	% plot(x(:,1),x(:,3),'r')
	% xlabel('x')
	% ylabel('y');
	% title('órbita de un planeta')
	


