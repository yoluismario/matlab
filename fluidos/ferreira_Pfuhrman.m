Q=3
Uinf=1

dr=0.05;
dt=2*pi/360;

rangr=0:dr:10;
rangt=0:dt:2*pi+dt;

[r,t]=meshgrid(rangr,rangt);
x=r.*cos(t);
y=r.*sin(t);
psi=Uinf*y+Q*t/(2*pi);
pimpx= Q*cos(pi)/(2*pi*Uinf)
pimpy= Q*sin(pi)/(2*pi*Uinf)

axis([-1.5,5,-4,4])

hold on
contour(x,y,psi,200);
contour(x,y,psi,1,'black','linewidth',1);
plot(pimpx,pimpy,'*')
hold off