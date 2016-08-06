%programa para vlidar el modelo de red de vortices inestacionaria 2d
clear; %close all
%placa plana horizontal fija, velocida de corriente libre con alpha
%variable
b=2;
n_el=40; %numero de elementos en toda la cuerda
n_nod=n_el+1;
long_el=b/(n_el/2); %longitud de un elemento
a=0; %parámetro que determina la posición del centro elástico respecto al centro de la placa
alpha=5;
Vinf=[cos(alpha*pi/180); sin(alpha*pi/180)];
deltat=long_el/norm(Vinf);
nsteps=50;


GG= zeros(n_el+1, nsteps); v_w_cp=zeros(2, n_el,nsteps+1); %VV_w_cp=zeros(2, n_el, nsteps);
RRHS=zeros(n_el+1, nsteps);
Rvpw=zeros(2, nsteps+1); RRvpw=zeros(2, nsteps+1,nsteps+1);
G_W=zeros(nsteps+1,1);
v_w_w=zeros(2,nsteps+1, nsteps+1);

Rnp=zeros(2,n_nod);  Rvp=zeros(2,n_nod); Rcp=zeros(2,n_el);

% Rnp(1,1)=-(1-a)*b;  Rvp(1,1)=Rnp(1,1)+0.25*long_el; Rcp(1,1)=Rnp(1,1)+0.75*long_el; 
for i=1:n_el
    Rnp(1,i)=-(1-a)*b+(i-1)*long_el;
    Rvp(1,i)=Rnp(1,i)+0.25*long_el;
    Rcp(1,i)=Rnp(1,i)+0.75*long_el;
end 
Rnp(1,n_nod)=Rnp(1,n_el)+long_el; Rvp(1,n_nod)=Rvp(1,n_el)+long_el;
nV=[0; 1];
%matriz A
A=zeros(n_nod);
for i=1:n_el
    for j=1: n_nod
      A( i,j)=nV'*Biot_Savart(Rcp(1,i),Rcp(2,i), Rvp(1,j),Rvp(2,j),1, 1e-6); 
    end
end
A(n_nod, 1:n_nod)=1;
RHS=zeros( n_nod,1);

%% isntante t=0
RHS(1:n_el)=-nV'*Vinf;
RRHS(:,1)=RHS;
G=A\RHS;
GG(:,1)=G;
%% convección de estela
%velocidad inducida por el ala en el nodo de la estela:

v_vp_w=zeros(2,nsteps+1, nsteps+1);

    for i=1:n_el
    v_vp_w(:,1,1)=v_vp_w(:,1,1)+Biot_Savart(Rvp(1,n_nod),Rvp(2,n_nod),Rvp(1,i),Rvp(2,i), G(i),1e-6); 
    end
Rvpw(:,1)=Rvp(:,n_nod)+Vinf*deltat+v_vp_w(:,1,1)*deltat;
RRvpw(:,1,1)=Rvpw(:,1);
G_W(1)=G(n_el+1);
n_elw=1;
%  fin paso de tiempo inicial

%% ciclo de integración temporal
for k=1:nsteps
    
 %velocidad inducida por la estela sobre el ala
    for j=1:n_el
        for i=1:n_elw
        v_w_cp(:,j,k+1)=v_w_cp(:,j,k+1)+Biot_Savart(Rcp(1,j), Rcp(2,j), Rvpw(1, i),Rvpw(2, i), G_W(i),1e-6); 
        end
        
%         VV_w_cp(:,j,k+1)=v_w_cp(:,j);
    end
    
    NV=kron(ones(1,n_el), nV);
    nvw=dot(NV,v_w_cp(:,:, k+1));
%solución para las circulaciones   
RHS(1:n_el)=-nV'*Vinf-nvw(1:n_el);
RHS(n_el+1)=RHS(n_el+1)-G_W(n_elw);
G=A\RHS;
GG(:,k+1)=G;
RRHS(:,k+1)=RHS;

%convección de la estela
%velocidad inducida por el ala sobre la estela 
for j=1:n_elw
    for i=1:n_el+1
    v_vp_w(:,j,k+1)=v_vp_w(:,j,k+1)+Biot_Savart(Rvpw(1,j),Rvpw(2,j),Rvp(1,i),Rvp(2,i), G(i),1e-6); 
    end
end

%velocidad inducida por la estela sobre sí misma 
for j=1:n_elw
    for i=1:n_elw
    v_w_w(:,j,k+1)=v_w_w(:,j,k+1)+Biot_Savart(Rvpw(1,j),Rvpw(2,j),Rvpw(1,i),Rvpw(2,i), G_W(i),1e-6); 
    end
end

%velocidades inducidas en el nodo del borde de fuga
    for i=1:n_el %por los vortices de la placa
    v_vp_w(:,n_elw+1,n_elw+1)=v_vp_w(:,n_elw+1,n_elw+1)+Biot_Savart(Rvp(1,n_nod),Rvp(2,n_nod),Rvp(1,i),Rvp(2,i), G(i),1e-6); 
    end
    for i=1:n_elw %por los vòrtices de la estela
    v_w_w(:,n_elw+1,n_elw+1)=v_w_w(:,n_elw+1,n_elw+1)+Biot_Savart(Rvp(1,n_nod),Rvp(2,n_nod),Rvpw(1,i),Rvpw(2,i), G_W(i),1e-6); 
    end


for i=1:n_elw
Rvpw(:,i)=Rvpw(:,i)+Vinf*deltat+v_vp_w(:,i,k+1)*deltat+v_w_w(:,i,k+1)*deltat;
end
Rvpw(:,n_elw+1)=Rvp(:,n_nod)+Vinf*deltat+v_vp_w(:,n_elw+1,k+1)*deltat+v_w_w(:,n_elw+1,k+1)*deltat;
RRvpw(:,:,k+1)=Rvpw(:,:);

G_W(n_elw+1)=G(n_el+1);
n_elw=n_elw+1;


end

figure(101)
 plot(Rnp(1, 1:n_nod),Rnp(2, 1:n_nod), '-')
    hold on
    plot(Rvp(1, 1:n_nod),Rvp(2, 1:n_nod), 'or')
    plot(Rcp(1, 1:n_el),Rvp(2, 1:n_el), 'xg')


   % for i=1:n_elw
    plot(Rvpw(1, 1:n_elw),Rvpw(2, 1:n_elw), '-xk')
% end
   %axis([-1.5*b 1.5*b -Amplitude_1-b Amplitude_1+b]);
%            M(i)=getframe;
 grid on;
 %hold off
 title('Estela vorticosa'), xlabel('x'), ylabel('y')
   
% movie(M)
                   