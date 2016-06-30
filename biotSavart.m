function Vij=biotSavart(v1,v2,cutoff)
% (x0,y0,xp,yp,cutoff)
xp =v1(1); yp=v1(2);
x0 =v2(1); y0=v2(2);
rq=(xp-x0)^2+(yp-y0)^2;
rq=max(rq,cutoff);
aux=1/(2*pi*rq);
Vij= aux*[0 1 ;-1 0]*[xp-x0; yp-y0];

% 
% function Vij=biotSavart(x0,y0,xp,yp)
% rx=sqrt((xp-x0)^2);ry=sqrt((yp-y0)^2);
% rx=
% aux=1/(2*pi);
% biotSavart= [rx*aux,ry*aux]