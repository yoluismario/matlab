function graficar(sistemaB,sistemaN,sistemaRN)
rcpB = sistemaB.controlpoints;
rvpB = sistemaB.vortexpoints;
rnpB = sistemaB.nodalpoints;
rcpN = sistemaN.controlpoints;
rvpN = sistemaN.vortexpoints;
rnpN = sistemaN.nodalpoints;

RcpN = sistemaRN.controlpoints;
RvpN = sistemaRN.vortexpoints;
RnpN = sistemaRN.nodalpoints;

% figure('Name','Sistema N','NumberTitle','off')
%graficar = [ceroN;ceroB;baN';bfN'];
% plot(graficar(:,1),graficar(:,2),'*')
axis square
grid on
hold on
plot(rnpB(1,:),rnpB(2,:),'bs')
plot(rvpB(1,:),rvpB(2,:),'bo')
plot(rcpB(1,:),rcpB(2,:),'b*')
% en sistema N
plot(rnpN(1,:),rnpN(2,:),'gs')
plot(rvpN(1,:),rvpN(2,:),'go')
plot(rcpN(1,:),rcpN(2,:),'g*')
% en sistema RN
plot(RnpN(1,:),RnpN(2,:),'rs')
plot(RvpN(1,:),RvpN(2,:),'ro')
plot(RcpN(1,:),RcpN(2,:),'r*')
% leyendas del grafico 1
legend('npB','cpB','vpB','npN','cpN','vpN','npRN','cpRN','vpRN')
% legend('puntos claves','npB','cpB','vpB')
%figure('Name','Sistema B','NumberTitle','off')
%graficar = [ceroB;baB;bfB] 
vec = ones(1,size(rcpB,2));
quiver(rcpB(1,:),rcpB(2,:),rcpB(2,:),vec)

end 
