% Resolucion del problema del teorico de una placa empotrada en los cuatro
% lados y sometida a una carga en el centro con una inclinacion de 22.5 deg
% respecto de la horizontal.
% la matriz de rigidez, luego de aplicadas las restricciones solo queda el
% elemento 5,5.
clf
P = 25000; E = 2.1e6; nu = 0.3;
alfa = 22.5;

nod_coord = [0 0; 80 0; 80 95;0 95;40 47.5];
elem_conect = [1 2 5;2 3 5;3 4 5; 4 1 5];
n_elem = 4;

% el problema es K u = F
F = P * [cosd(alfa); -sind(alfa)];
% la matriz de rigidez del ensamble se transforma en:
K_55 = zeros(2);
for i=1:n_elem
    idx = elem_conect(i,:);
    coord = [nod_coord(idx(1),:);nod_coord(idx(2),:);nod_coord(idx(3),:)];
    kij= f_mat_k_elemental(coord,E,nu);
    K_55 = K_55 +kij;
    patch(coord(:,1),coord(:,2),i);
end
u = K_55\F
% deformaciones 
eps = zeros(n_elem,3);
for i=1:n_elem
    idx = elem_conect(i,:);
    coord = [nod_coord(idx(1),:);nod_coord(idx(2),:);nod_coord(idx(3),:)];
    eps(i,:)= f_eps_elemento(coord,E,nu,u);
    tensiones(i,:) = f_tensiones_elemento(eps(i,:),E,nu); 
    patch(coord(:,1),coord(:,2),tensiones(i,4));
end
colorbar; xlabel('x_1');ylabel('x_2');title('tensiones de Von Mises');

% flecha
x = [0.5 0.7];  y = [0.5 (0.5*(1-sind(alfa)))];
a = annotation('textarrow',x,y,'String','P');
a.Color ='red';
disp('tensiones')
disp(tensiones)
% print('tensiones','-dpng')