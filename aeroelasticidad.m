function aeroelasticidad
tic
U = [1 0];
b = 2;
h = 1;
nel = 4; % numero de elementos
a = 0;
theta = 15; %en grados
theta = deg2rad(theta);

% genera la geometría en ambos sistemas B y N
geom = geometria(a,b,h,nel,theta);
toc

%conveccion de la estela
conveccion


% graficar: funcion que realiza los gráficos de 
 graficar(geom.sistema(1),geom.sistema(2),geom.sistema(3))
toc
end
