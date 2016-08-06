%% programa para hacer diagramas de fase para el oscilador simple normalizado
%d^2x dt^2+ 2*c *dx/dt+k*x=0
k=0;
c=0;
IC=zeros(10,2);
omega=sqrt(k-c^2);
% condición inicial
for i=1:10
% IC(i,:)=[-5; -5+i];
% %IC(10+i,:)=[-5+i; 5];
% IC(20+i,:)=[5;5-i];
%IC(30+i,:)=[-5+i; -5];

% IC(i,:)=[-5+i; 1];
% IC(10+i,:)=[-5+i; -1];

IC(i,:)=[-5; i-1];
IC(10+i,:)=[5; -i];


end
x=zeros(60,2,length(IC));
%matriz del sistema
A=[0 1; -k -2*c];
%valores propios y vectores propios
[eigenv, Lambda]=eig(A);
%período (si hubiera)
%T=2*pi/omega;
X=zeros(40,2,10);
for i=1:length(IC)
[t,xi]=ode45(@(t,x) osciladorsimple(t,x,A),[0 10], IC(i,:)) ;
X(1:length(xi),1:2,i)=xi;
end


%% gráficos

% gráficos de flechitas: evaluamos dot(x1) y dot(x2)
% x1=linspace(-10,10,20);
% y1=linspace(-10*k,10*k,20);
% 
% [xq, yq]=meshgrid(x1,y1);

% uq = zeros(size(xq));
% vq = zeros(size(xq));
%t=0; % we want the derivatives at each point at t=0, i.e. the starting time
% for i = 1:numel(xq)
%     dx = osciladorsimple(t,[xq(i); yq(i)], A);
%     uq(i) = dx(1);
%     vq(i) = dx(2);
% end


%diagrama de fases
figure(10)
plot(X(1:size(X,1)-8,1, 1), X(1:size(X,1)-8,2,1))
hold on
xq=X(5:5:size(X,1),1, 1); yq=X(5:5:size(X,1),2,1);
uq = zeros(size(xq));
vq = zeros(size(xq));
for j=1:numel(xq)
dx = osciladorsimple(t,[xq(j); yq(j)], A);
uq(j) = dx(1);
vq(j) = dx(2);
end
quiver(xq,yq,uq,vq,.9,'r')%,'Autoscale','off');
for i=2:length(IC)
    
    plot(X(:,1, i), X(:,2,i))
       xq=X(5:5:size(X,1)-1,1, i); yq=X(5:5:size(X,1)-1,2,i);
       uq = zeros(size(xq));
vq = zeros(size(xq));
    for j=1:numel(xq)
        dx = osciladorsimple(t,[xq(j); yq(j)], A);
        uq(j) = dx(1);
        vq(j) = dx(2);
    end
    quiver(xq,yq,uq,vq,.2,'r')%,'Autoscale','off');
   
end
  axis equal
    %quiver(xq,yq,uq,vq,'r');
hold off
grid on
 set(gca,'xlim',[-5 5]);
 set(gca,'ylim',[-5 5]);
xlabel('x')
ylabel ('$\dot{ x}$', 'Interpreter', 'latex')