%% doblete en el origen
mu = 1;  % Intensidad del doblete
% GRID:
x = -2:.02:2;
y = -2:.02:2;
for m = 1:length(x)
    for n = 1:length(y)
        xx(m,n) = x(m);
        yy(m,n) = y(n);
        % Velocity potential function:
        phi_Doublet(m,n) = mu*x(m)/(x(m)^2+(y(n)+.01)^2);
        % Stream function:
        psi_Doublet(m,n) = - mu*y(n)/(x(m)^2+(y(n)+.01)^2);
    end
end
% Plots
% Doublet at origin of coordinate system:\figure(4)
contour(xx,yy,psi_Doublet,[-2:.5:2],'k'),hold on
contour(xx,yy,phi_Doublet,[-10:1:10],'r')
legend('lineas de corriente (\psi)' ,'potencial (\phi)')
title(' Doblete en el origen')
axis image,hold off