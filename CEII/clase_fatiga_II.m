% fatiga daño acumulado
d = linspace(3,51);
d2 = linspace(51,120);
f_T1=@(d) 1.24*d.^-0.107;% 3<d<51
f_T2=@(d) 1.51*d.^-0.157;%51< d < 254
y1 = f_T1(d);
y2 = f_T2(d);
plot(d,y1,d2,y2)

grid on
