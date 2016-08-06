k=0:0.1:6;
c=sqrt(k);
ejex=[-6;6 ];
ejey=[-6;6 ];
figure(20)
plot(ejex,[0;0],'k')
hold on
plot([0;0],ejey,'k')
plot(k,c)
plot(k,-c)
hold off

 set(gca,'xlim',[-6 6]);
 set(gca,'ylim',[-6 6]);
grid on