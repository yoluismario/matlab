entrada=fopen('input2.txt','r');
b=fscanf(entrada,'%*[b=] %f \n');
a=fscanf(entrada,'%*[a=] %f\n');
h=fscanf(entrada,'%*[h=] %f\n');
theta=fscanf(entrada,'%*[theta=] %f\n');
nel=fscanf(entrada,'%*[nel=] %f\n');
din=fscanf(entrada,'%*[din=] %i\n');
Amplitude_1=fscanf(entrada,'%*[Amplitud1=] %f\n');
Amplitude_2=fscanf(entrada,'%*[Amplitude2=] %f\n');
Omega_1=fscanf(entrada, '%*[Omeg1=] %f\n');
Omega_2=fscanf(entrada, '%*[Omega2=] %f\n');
Phi_1=fscanf(entrada, '%*[Ph1=] %f\n');
Phi_2=fscanf(entrada, '%*[Phi2=] %f\n');
nsteps=fscanf(entrada, '%*[nsteps=] %i\n');
t_i=fscanf(entrada, '%*[t_i=] %f\n');
t_f=fscanf(entrada, '%*[t_f=] %f\n');
V_inf=fscanf(entrada, '%*[V_inf=] %f\n');
alpha=fscanf(entrada, '%*[alpha=] %f\n');
fclose(entrada);

alpha=deg2rad(alpha);


%disp(Phi_1); disp( Phi_2);
if (1+a)*b >2*b
    disp 'error en entrada de datos: a incorrecto'
    return
end
if mod(a,2/nel)~=0
   disp  'el valor de a no puede discretizarse con nel'
    return
end
nnp= nel+1; nvp=nel; ncp=nel;
long_el=2*b/nel;
cant_el_izq=(1+a)* b / long_el; cant_el_der=(1-a)* b / long_el;


rnpB=zeros(2, nnp); rvpB=zeros(2, nel); rcpB=zeros(2, nel);
rnpB(1,1)=-(1+a)*b;

    %% coord en ejes cuerpo resp a O
for i=1:nel
    rnpB(1,i+1)=-(1+a)*b+i*long_el;
    rvpB(1,i)=-(1+a)*b+0.25*long_el+(i-1)*long_el;
    rcpB(1,i)=-(1+a)*b+0.75*long_el+(i-1)*long_el;
end
% normales resp a sist de ejes cuerpo
normalsB=zeros(2, nel);
for i=1:nel
%     nVN(:,i)=rnpN(:,i+1)-rnpN(:,i); 
%     nVN(:,i)=nVN(:,i)/norm(nVN(:,i));
%     nVN(:,i)=rot1g(nVN(:,i),90);
    
    normalsB(:,i)=rnpB(:,i+1)-rnpB(:,i); 
    normalsB(:,i)=normalsB(:,i)/norm(normalsB(:,i));
    normalsB(:,i)=rot1g(normalsB(:,i),-90);
    %nVB(1,i)=nVB(1,i)+rcpB(1,i);
end


%% aerodinámica
V_inf=[V_inf, 0]; %velocidad en ejes inerciales
A=zeros(nel+1); %matriz de coeficientes de influencia
coff=1e-6;
G=zeros(nel+1,1); %circulaciones de vórtices adheridos (en cierto instante)
G_w=zeros(nsteps,1); %circulaciones de vórtices adheridos (en cierto instante)
nelw=0; %elementos de la estela (crece con el tiempo)
V_w_w=zeros(2, nsteps); %velocidad de la estela sobre sì misma
V_w_cp=zeros(2, nel); %velocidad de la estela sobre los cp de la placa
V_vp_w=zeros(2, nsteps); %velocidad de la placa sobre la estela
RHS=zeros(nel+1,1); % miembro derecho de la ecuación para calcular los G
if din==0
%% cálculo "estatico"
thetad=theta;
theta=deg2rad(theta);
Ctheta=ones(2)*cos(theta); Stheta=ones(2)*sin(theta);
CBN=[Ctheta, -Stheta;Stheta , Ctheta ]; % vectrix
CNB=CBN'; 
n1=[1;0]; n2=[0;1];

hatb=CBN*[n1;n2];

cbn=[cos(theta),-sin(theta); sin(theta), cos(theta)]; cnb=cbn';
rnpN=cnb*rnpB; rvpN=cnb*rvpB; rcpN=cnb*rcpB; %rotación por angulo theta

%% coordenadas resp a sistema N
RnpN=rnpN+kron(ones(1, size(rnpN,2)),[0;h]);
RvpN=rvpN+kron(ones(1, size(rvpN,2)),[0;h]);
RcpN=rcpN+kron(ones(1, size(rcpN,2)),[0;h]);


%% vectores normales
normalsN=zeros(2, nel); 


%nVB(1,:)=nVB(1,:)+0.25*long_el; %corrección para ubicarlos en el Pto de control

for i =1:nel
    normalsN(:,i)=rot1g(normalsB(:,i),thetad);
end

%% aerodinámica
%ensamble de la matriz A
for i=1:nel %recorre los puntos de control
    for j=1:nel %calcula la influencia de cada vórtice concentrado
    A(i,j)=normalsB(:,i)'*Biot_savart(rcpB(1, i), rcpB(2, i),rvpB(1, j), rvpB(2, j), 1, coff);
    end
    A(i,nel+1)=normalsB(:,i)'*Biot_savart(rcpB(1, i), rcpB(2, i),rvpB(1, j)+long_el/4, rvpB(2, j), 1, coff);
end
A(nel+1,:)=1;


%% velocidades "inducidas" en  la placa por la estela
for j=1:nelw% calcula la influencia de cada elemento de la estela
    for i=1:nel  %en el control point de la paca
    V_w_cp(i)=V_w_cp(i)+Biot_savart(RcpN(1,i),RcpN(2,i), RvpWN(1,j),RvpWN(2,j), G_w(j),coff);
    end
end


%% velocidades "inducidas" en segmentos de la estela por la placa
for j=1:nel% calcula la influencia de cada elemento de la placa
    for i=1:nelw  %en el vortex piont convectado de la estela
    V_vp_w(i)=V_vp_w(i)+Biot_savart(RvpWN(1,i),RvpWN(2,i), RvpN(1,j),RvpN(2,j), G(j),coff);
    end
end
%% velocidades "inducidas" en segmentos de la estela por la estela
for j=1:nelw% calcula la influencia de cada elemento
    for i=1:nelw
    V_w_w(i)=V_w_w(i)+Biot_savart(RvpWN(1,i),RvpWN(2,i), RvpWN(1,j),RvpWN(2,j), G_w(j),coff);
    end
end


%% miembro derecho de los coef aerodin.
V_infn=V_inf*normalsN(:,:);
RHS=-dot(normalsN ,V_w_cp)'-V_infn';
RHS(nel+1)=0;
G=A\RHS;

%%Solución del sist de ecuaciones para G 

% figure(10)
% quiver(rcpB(1,:),rcpB(2,:),nVB(1,:),nVB(2,:))
% 
% figure(11)
% quiver(rcpN(1,:),rcpN(2,:),nVN(1,:),nVN(2,:))

a = 1:nel;  a=a';    b = num2str(a); c = cellstr(b);
a1 = 1:nnp; a1=a1';  b1 = num2str(a1); c1 = cellstr(b1);

figure(1)
subplot (1,2,1)
plot(rnpB(1,:),rnpB(2,:), 's', rvpB(1,:),rvpB(2,:), 'o',rcpB(1,:),rcpB(2,:), 'x')  
hold on
quiver(rcpB(1,:),rcpB(2,:),normalsB(1,:),normalsB(2,:),'Autoscale','off' )
text(rnpB(1,:),rnpB(2,:)+0.1, c1)
grid on
hold off
subplot (1,2,2)
plot(RnpN(1,:),RnpN(2,:), 's', RvpN(1,:),RvpN(2,:), 'o',RcpN(1,:),RcpN(2,:), 'x') 
hold on
quiver(RcpN(1,:),RcpN(2,:),normalsN(1,:),normalsN(2,:) ,'Autoscale','off' )
text(RnpN(1,:)-0.2,RnpN(2,:)-0.1, c1,'Color','blue')
text(RcpN(1,:)-0.2,RcpN(2,:)-0.1, c,'Color','red')
text(RvpN(1,:)-0.2,RvpN(2,:)-0.1, c,'Color','green')
grid on
hold off

%% simulación con movimiento. 
else  
%% asignación de memoria para matrices
theta=zeros(nsteps, 1); h=zeros(nsteps, 1);
dot_theta=zeros(nsteps, 1); dot_h=zeros(nsteps, 1);

Phi_1=degtorad(Phi_1); Phi_2=degtorad(Phi_2);
Amplitude_2=degtorad(Amplitude_2);

RB=zeros(nsteps, 2);
t=t_i:(t_f-t_i)/nsteps:t_f;
rnpN=zeros(2, nnp,nsteps); rvpN=zeros(2, nel,nsteps); 
rcpN=zeros(2, nel, nsteps);
RnpN=zeros(2, nnp,nsteps); RvpN=zeros(2, nel,nsteps); 
RcpN=zeros(2, nel, nsteps);
rnpB(1,1)=-(1+a)*b;
normalsN=zeros(2, nel, nsteps); 
vcpB=zeros(2,nel, nsteps); vcpN=zeros(2,nel, nsteps);
VcpN=zeros(2,nel, nsteps);
%ciclo de integración temporal

    for k=1:nsteps
      h(k)=Amplitude_1*sin(Omega_1*t(k)+Phi_1);            
      theta(k)=Amplitude_2*sin(Omega_2*t(k)+Phi_2);   
    
      %hatb=CBN*[n1;n2];

      cbn=[cos(theta(k)),-sin(theta(k)); sin(theta(k)), cos(theta(k))]; cnb=cbn';
      rnpN(:,:, k)=cnb*rnpB; rvpN(:,:, k)=cnb*rvpB; 
      rcpN(:,:, k)=cnb*rcpB; %rotación por angulo theta

        %% coordenadas resp a sistema N
    RnpN(:,:,k)=rnpN(:,:,k)+kron(ones(1, nnp),[0;h(k)]);
    RvpN(:,:,k)=rvpN(:,:,k)+kron(ones(1, nel),[0;h(k)]);
    RcpN(:,:,k)=rcpN(:,:,k)+kron(ones(1, nel),[0;h(k)]);

    %% calculos aerodinamicos

%ensamble de la matriz A
for i=1:nel %recorre los puntos de control
    for j=1:nel %calcula la influencia de cada vórtice concentrado
    A(i,j)=Biot_savart(rcpB(1, i), rcpB(2, i),rvpB(1, j), rvpB(2, j), 1, coff);
    end
    A(i,nel+1)=Biot_savart(rcpB(1, i), rcpB(2, i),rvpB(1, j)+long_el/4, rvpB(2, j), 1, coff);
end
A(nel+1,:)=1;

%% vectores normales
%nVB(1,:)=nVB(1,:)+0.25*long_el; %corrección para ubicarlos en el Pto de control

    for i =1:nel
    normalsN(:,i, k)=rot1g(normalsB(:,i),theta(k)*180/pi);
    end
%velocidad de los puntos de control
dot_h(k)=Amplitude_1*Omega_1*cos(Omega_1*t(k)+Phi_1);% dh/dt
dot_theta(k)=Amplitude_2*Omega_2*cos(Omega_2*t(k)+Phi_2);% dh/dt

    for i=1:nel
    vcpB(2,i, k)=-dot_theta(k)*norm(rcpB(:,i));
    vcpN(:,i, k)=rot1g(vcpB(:,i, k),theta(k));
    VcpN(:,i, k)=[0;dot_h(k)]+vcpN(:,i, k);
    end

    end
figure(5)
plot(RnpN(1,:,1),RnpN(2,:,1), 's', RvpN(1,:,1),RvpN(2,:,1), 'o',RcpN(1,:,1),RcpN(2,:,1), 'x') 

hold on
quiver(RcpN(1,:,1),RcpN(2,:,1),normalsN(1,:,1),normalsN(2,:,1) ,'Autoscale','off' )

plot(RnpN(1,:,floor(length(t)/2)),RnpN(2,:,floor(length(t)/2)), 's', RvpN(1,:,floor(length(t)/2)),RvpN(2,:,floor(length(t)/2)), 'o',RcpN(1,:,floor(length(t)/2)),RcpN(2,:,floor(length(t)/2)), 'x') 
quiver(RcpN(1,:,floor(length(t)/2)),RcpN(2,:,floor(length(t)/2)),normalsN(1,:,floor(length(t)/2)),normalsN(2,:,floor(length(t)/2)) ,'Autoscale','off' )
% text(RnpN(1,:)-0.2,RnpN(2,:)-0.1, c1,'Color','blue')
% text(RcpN(1,:)-0.2,RcpN(2,:)-0.1, c,'Color','red')
% text(RvpN(1,:)-0.2,RvpN(2,:)-0.1, c,'Color','green')
hold off
grid on

%%animación
for i=1:nsteps
    plot([RnpN(1,1,i),RnpN(1,nnp,i)],[RnpN(2,1,i),RnpN(2,nnp,i)],'LineWidth',1.1);hold on; 
    plot([RnpN(1,1,i),RnpN(1,nnp,i)],[0,0],'b','LineWidth',1.5);

    %grafico los puntos del frame N y B
    plot([0 0],[0 h(i)],'.','LineWidth',10.);

    %grafico los frame fijo y movil
    quiver([0 0],[0 0],[0 2^0.5/2],[2^0.5/2 0],'r','LineWidth',1.5) %frame N
    quiver([0 0],[h(i) h(i)],[2^.5/2*cos(theta(i)) 2^.5/2*sin(theta(i))],[-2^0.5/2*sin(theta(i)) 2^0.5/2*cos(theta(i))],'r','LineWidth',1.5) %frame B

    %grafico los np
    plot([RnpN(1,:,i)],[RnpN(2,:,i)],'k','marker','s');

    %grafico los vp
    plot([RvpN(1,:,i)],[RvpN(2,:,i)],'g','marker','o');

    %grafico los cp
    plot([RcpN(1,:,i)],[RcpN(2,:,i)],'r','marker','x');

    %grafico los vectores normales
    quiver(RcpN(1,:,i),RcpN(2,:,i),normalsN(1,:,i),normalsN(2,:,i));
    
    %axis equal
    axis([-1.5*b 1.5*b -Amplitude_1-b Amplitude_1+b]);
    title('animacion de placa 2D'), xlabel('x'), ylabel('y')
    grid on;  
    M(i)=getframe;
    hold off
end
movie(M)

%% variables para control
GammaTot=sum(G);

end