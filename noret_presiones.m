% explosiones
function noret_presiones(b,t_plus)
P_0 = 101325*10^-6; %presion atmosferica en MPa
% t_plus= 10; % milisegundos de 10 a 200
Dp = 0.5; % delta de presion en MPa
% b = 0.1;% parametro

p_temp=@(t) P_0 + Dp*(1+t/t_plus)*exp(-b*t/t_plus);

tic

for i=1:1000
    x(i)=i;
    y(i)=p_temp(i);
end


hold all
plot(x,y)

% Create axes
ax = gca;
ax.Title.String = 'Modelo Noret';
% Create xlabel
xlabel('t [ms]');
% Create ylabel
ylabel('\Delta P [MPa]');
ax.TickDir = 'in';
box(ax,'on');
% Set the remaining axes properties
set(ax,'XGrid','on','YGrid','on');
toc
end