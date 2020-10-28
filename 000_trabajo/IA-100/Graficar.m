% graficar
clf

hold on;
grid on;
% Create xlabel
xlabel('velocidad [knot]');
% Create ylabel
ylabel('Traccion [lbf]');
legend(

for i=1:4;
    plot(velocidades,M_T_ij(i,:,2),'*');
end

% print('potencia_o_H','-dpng')