% comparación CL vs CD
CD_limpio=@(CL)0.0350- 0.0381*CL + 0.085*CL.^2;
CD_tren  =@(CL)0.0303- 0.0134*CL + 0.0698*CL.^2;

CL_graficar = 0:.01:1.8;

CD_1 = CD_limpio(CL_graficar);
CD_2 = CD_tren(CL_graficar);
lift2drag_1 = CL_graficar./CD_1;
lift2drag_2 = CL_graficar./CD_2;

subplot(1,2,1)
plot(CL_graficar,CD_1,CL_graficar,CD_2)
grid on 
title('Comparación Polares IA-100A con y sin tren')
xlabel('C_L'); ylabel('C_D')
legend('Avión limpio','Avión con tren')

subplot(1,2,2)
plot(CL_graficar,lift2drag_1,CL_graficar,lift2drag_2)
grid on 
title('Comparación (L/D) IA-100A con y sin tren')
xlabel('C_L'); ylabel('C_L/C_D')
legend('Avión limpio','Avión con tren')

max(lift2drag_1)