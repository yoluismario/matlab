% Resolucion del problema del teorico de una placa empotrada en los cuatro
% lados y sometida a una carga en el centro con una inclinacion de 22.5 deg
% respecto de la horizontal.
% la matriz de rigidez, luego de aplicadas las restricciones solo queda el
% elemento 5,5.
% clf
P = 5000; E = 2.1e6; nu = 0.3;
alfa = 22.5;

nod_coord = [120 0; 120 200; 0 200;0 0];
elem_conect = [1 3 4;1 2 3];
n_elem = 2;
h = 1; %espesor de las placas

% el problema es K u = F
F = P * [cosd(alfa); sind(alfa)];
% la matriz de rigidez del ensamble se transforma en:
K_55 = zeros(2);
for i=1:n_elem
    idx = elem_conect(i,:);
    coord = [nod_coord(idx(1),:);nod_coord(idx(2),:);nod_coord(idx(3),:)];
    kij= f_mat_k_elemental(coord,E,nu,h);
    K_55 = K_55 +kij;
%     patch(coord(:,1),coord(:,2),i);
end
%%%%%%%%% la matriz de rigidez les da exactamente el doble ???? %%%%
K_55 = K_55
u = inv(K_55)*F


% deformaciones 
eps = zeros(n_elem,3);
for i=1:n_elem
    idx = elem_conect(i,:);
    coord = [nod_coord(idx(1),:);nod_coord(idx(2),:);nod_coord(idx(3),:)];
    eps(i,:)= f_eps_elemento(coord,E,nu,u);
    tensiones(i,:) = f_tensiones_elemento(eps(i,:),E,nu); 
%     patch(coord(:,1),coord(:,2),tensiones(i,4));
end
% colorbar; xlabel('x_1');ylabel('x_2');title('tensiones de Von Mises');

% flecha
% x = [0.5 0.7];  y = [0.5 (0.5*(1-sind(alfa)))];
% a = annotation('textarrow',x,y,'String','P');
% a.Color ='red';
fprintf('Tensiones, ordenadas por elemento,\n [tens(1) tens(2) tens(3) S_vm]\n')
disp(tensiones)
% print('tensiones','-dpng')


