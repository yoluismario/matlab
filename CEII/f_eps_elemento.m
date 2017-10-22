% calcula la matriz de rigidez de elemental.
% entran como argumentos los valores de las coordenadas en forma ordenada,
% el módulo de elasticidad y de poisson.

function eps_elem = f_eps_elemento(coord,E,nu,u)
h =1;
ai1 = coord(3,1)-coord(2,1);
ai2 = coord(3,2)-coord(2,2);

aj1 = coord(1,1)-coord(3,1);
aj2 = coord(1,2)-coord(3,2);

ak1 = coord(2,1)-coord(1,1);
ak2 = coord(2,2)-coord(1,2);

As = [ai1 ai2; aj1 aj2; ak1 ak2];
area = 0.5*(aj1*ak2-aj2*ak1);

alfa = (E*h)/(4*area*(1-nu^2));
beta = (1-nu)/2;
% deformaciones
u_ijk = [0 0 u(1); 0 0 u(2)];

eps11 = -(u_ijk(1,3)*ak2)/(2*area);
eps22 = (u_ijk(2,3)*ak1)/(2*area);
eps12 = (u_ijk(1,3)*ak1-u_ijk(2,3)*ak2)/(4*area);

eps_elem=[eps11 eps22 eps12];

end