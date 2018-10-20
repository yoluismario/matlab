% calcula la matris de rigidez de elemental.
% entran como argumentos los valores de las coordenadas en forma ordenada,
% el módulo de elasticidad y de poisson.

function kij = f_mat_k_elemental_jj(coord,E,nu,h)
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

% solo calculamos la ubicación kk de la matriz elemental
k11 = (ak2*ak2+beta*ak1*ak1);
k12 = -(nu*ak1*ak2+beta*ak2*ak1);
k22 = (ak1*ak1+beta*ak2*ak2);

kij = alfa * [k11 k12;k12 k22];
end