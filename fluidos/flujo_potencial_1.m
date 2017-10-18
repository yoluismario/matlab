%%  funcion potencial
V_inf = 1;
alfa = 0;

stream =@(V_inf,x,y)V_inf * (sind(alfa)+cosd(alfa));

x = linspace(0,10);
y = linspace(0,10);
clf

for i=1:5
    V_inf = i;
    hold on
    plot(x,stream(V_inf,x,y),'.')
end

hold off