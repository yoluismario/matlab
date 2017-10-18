% FUENTE
sig = 1; % Source strength
% GRID:
x = -2:.02:2;
y = -2:.02:2;
for m = 1:length(x)
    for n = 1:length(y)
        xx(m,n) = x(m); yy(m,n) = y(n);
        % Velocity potential function:
        phi_Source(m,n) = (sig/4/pi)*log(x(m)^2+(y(n)+.01)^2);
        % Funcion de corriente:
        psi_Source(m,n) = (sig/2/pi)*atan2(y(n),x(m));
    end
end
% Plots
% Source at origin of coordinate systex:
contour(xx,yy,psi_Source,[-.5:.05:.5],'k'),hold on
contour(xx,yy,phi_Source,10,'r')
legend('Lineas de corriente' ,'potencial')
title(' Fuente en el origen')
axis image,hold off