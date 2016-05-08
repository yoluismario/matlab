function z=func_radioactivo(t,x,a,b)
% funcion para probar el uso de odes
    z=[-a*x(1);a*x(1)-b*x(2)]; % x(1) es x, x(2) es y
end