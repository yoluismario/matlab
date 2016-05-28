function Vij=biotSavart(x0,y0,xp,yp)
rx=sqrt((xp-x0)^2);ry=sqrt((yp-y0)^2);
aux=1/(2*pi);
biotSavart= [rx*aux,ry*aux]