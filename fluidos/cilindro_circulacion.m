%% cilindro con circulación
mu = 1; gam = -2; V=1;
x = -3:.02:3;
y = -2:.02:2;
for m = 1:length(x)
for n = 1:length(y)
xx(m,n) = x(m); yy(m,n) = y(n);
psis(m,n) = V*y(n) - mu*y(n)/(x(m)^2+(y(n)+.01)^2) ...
    - (gam/4/pi)*log(x(m)^2+(y(n)+.01)^2);
end
end
contour(xx,yy,psis,[-3:.3:3],'k'), axis image