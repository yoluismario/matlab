a = 5;
b = -1;
c = 15; 
d = 10; 
e = 4;
f = -20;
S_ij = [a b c;b d e; c e f]

[D_i,V_i] = eig(S_ij);
disp('Tensiones principales'); V_i
disp('Direcciones principales'); D_i

alfad = 30; alfa = deg2rad(alfad);
R = [cos(alfa) -sin(alfa) 0;sin(alfa) cos(alfa) 0; 0 0 1]

S_ij_prima = R'*S_ij*R

%% parte a
clf
clear
a = 30; % mm
b = 25; % mm
vDelta = linspace(0,.05,100); % mm
E = 73500;
nu = 0.3;

M_s = zeros(size(vDelta,2),5);

for i= 1:100
    delta = vDelta(i);
    eps_11(i) = delta/(a+delta);
    eps_22(i) = delta/(b+delta);
    s_11(i) = E/(1-nu^2)*(eps_11(i)+nu*eps_22(i) );
    s_22(i) = E/(1-nu^2)*(eps_22(i)+nu*eps_11(i));
    M_s(i,:) = [delta eps_11(i) eps_22(i) s_11(i) s_22(i)];
end

plot(vDelta,M_s(:,4:5)); legend('\sigma_{11}','\sigma_{22}')
ylabel('\sigma [MPa]'); xlabel('\Delta [mm]')
grid on
hold on

delta = 0.04
    eps_11 = delta/(a+delta)
    eps_22 = delta/(b+delta)
    s_11 = E/(1-nu^2)*(eps_11+nu*eps_22 )
    s_22 = E/(1-nu^2)*(eps_22+nu*eps_11)
    eps_33 = -nu/(1-nu)*(eps_11+eps_22)
    
    plot(delta,s_22,'*')
    legend('\sigma_{11}','\sigma_{22}','\delta = 0.042163 [mm]')
hold off
% saveas(gcf,'ejercicio_1.png')
alfaT = 22E-6;
Dt = eps_22/alfaT


