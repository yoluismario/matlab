clear all
clc

%constantes
degtorad=pi/180;
radtodeg=180/pi;

%valores para leer desde archivo: l [m], angulos [grados]------------------
a=0.;
b=5 ;
%h=10 ;
%theta=-45 ;
n_el=10 ;
%--------------------------------------------------------------------------

%h y theta son funciones del tiempo:---------------------------------------
%Valores de h=f(t): h=A*sin(amega_1*t+phi_1)
A=10; %amplitud
omega_1=2.; %[rad/s]
phi_1=30;

%Valores de theta=f(t): theta=B*sin(amega_2*t+phi_2)
B=0.5; %amplitud
omega_2=10.; %[rad/s]
phi_2=10;

%parámetros de la simulacion
n_steps=500;
ti=0; %[s]
tf=10; %[s]
%--------------------------------------------------------------------------

%se lee el archivo
l=2*b ;
%theta=theta*degtorad ;
phi_1=phi_1*degtorad ;
phi_2=phi_2*degtorad ;
h_steps=(tf-ti)/n_steps; %[s] duracion de los pasos de tiempo

%se verifica que el punto B caiga dentro del dominio
while ((1+a)<0)||((1+a)*b>2*b)
    disp('valor del par�metro a fuera de rango');  
    a=input('  Ingrese nuevo valor de a entre [-1,1]: ');    
%    ver como finalizar el programa
end
orig_b=(1+a)*b;

%obtenemos par�metros de las celdas
n_np=n_el+1;
he=2*b/n_el;
n_vp=n_el ; l_vp=0.25*he;
n_cp=n_el ; l_cp=0.75*he;

%Vectores en el frame B
%obtenemos las coordenadas de los nodos de cada elemento en el sist. B:
rnpB=zeros(2,n_np);
for j=1:n_np
    rnpB(1,j)=-orig_b+(j-1)*he;
end

%obtenemos las coordenadas de los vp de cada elemento en el sist. B:
rvpB=zeros(2,n_vp);
for j=1:n_vp
    rvpB(1,j)=rnpB(1,j)+l_vp;
end  

%obtenemos las coordenadas de los cp de cada elemento en el sist. B:
rcpB=zeros(2,n_vp);
for j=1:n_cp
    rcpB(1,j)=rnpB(1,j)+l_cp;
end

%damos dimension a las matrices de coordenadas
%C_BN=zeros(2,2,n_steps); C_NB=C_BN;
rnpN=zeros(2,n_np,n_steps); RnpN=rnpN; 
rcpN=zeros(2,n_cp,n_steps); rvpN=rcpN; RcpN=rcpN; RvpN=rvpN; normal_N=rcpN;
VcpN=zeros(2,n_cp,n_steps); h=zeros(n_steps); h_p=h; theta=h; theta_p=h;

t=ti;
for i=1:n_steps
    %obtenemos para cada paso theta=f(t) y h=f(t)
    theta(i)=B*sin(omega_2*t+phi_2);
    theta_p(i)=B*omega_2*cos(omega_2*t+phi_2);
    
    h(i)=A*sin(omega_1*t+phi_1);
    h_p(i)=A*omega_1*cos(omega_1*t+phi_1);
    
    %si queremos valirdar para theta=cte y h=cte.--------------------------
%     theta(i)=30*degtorad;
%     h(i)=10;
    %----------------------------------------------------------------------
    
    %Definimos la matriz de rotacion
    C_BN=[cos(theta(i)) -sin(theta(i));sin(theta(i)) cos(theta(i))];
    C_NB=C_BN';   %matriz trspuesta de C_BN

    %Vectores en el frame N
    rnpN(:,:,i)=C_NB*rnpB;
    rcpN(:,:,i)=C_NB*rcpB;
    rvpN(:,:,i)=C_NB*rvpB;

    %Obtenemos los vectores R
    %matriz que almacena la altura h del sistema B
    H_np=zeros(2,n_np); H_np(2,:)=h(i);
    H_el=zeros(2,n_el); H_el(2,:)=h(i);

    %sumamos para obtener los R
    RnpN(:,:,i)=rnpN(:,:,i)+H_np;
    RcpN(:,:,i)=rcpN(:,:,i)+H_el;
    RvpN(:,:,i)=rvpN(:,:,i)+H_el;

    %obtenemos las componentes de los vectores normales en cada cp en el sist B
    normal_B=zeros(2,n_cp); 
    normal_B(2,:)=1;
    %Obtenemos las componentes de los vectores normales en el sistema N
    normal_N(:,:,i)=C_NB*normal_B;
    %normalizamos
    for j=1:n_cp
      normal_N_mod=norm(normal_N(:,j,i),2);
      normal_N(:,j,i)=normal_N(:,j,i)/normal_N_mod;
    end
    
    %Obtenemos el vector VcpN para caso paso de tiempo i:
    R_B_p=[0 h_p(i)]; %velocidad del punto B respecto al frame N
    for j=1:n_cp
        VcpN(:,j,i)=R_B_p'+C_NB*[0 -theta_p(i)*norm(rcpN(:,j),2)]';
    end
    
    t=t+h_steps; %[s] avanzo un paso de tiempo
    
end 
    
    
    
%Se realizan los graficos--------------------------------------------------
%axis([-RnpN(1,1),RnpN(1,1),-2*h,2*h]);

%Graficamos en el paso de tiempo i:
%set(gca,'nexplot','replacechildren')
%M=zeros(n_steps);
for i=1:n_steps
    plot([RnpN(1,1,i),RnpN(1,n_np,i)],[RnpN(2,1,i),RnpN(2,n_np,i)],'LineWidth',1.1);hold on; 
    plot([RnpN(1,1,i),RnpN(1,n_np,i)],[0,0],'b','LineWidth',1.5);

    %grafico los puntos del frame N y B
    plot([0 0],[0 h(i)],'.','LineWidth',10.);

    %grafico los frame fijo y movil
    quiver([0 0],[0 0],[0 2^0.5/2],[2^0.5/2 0],'r','LineWidth',1.5) %frame N
    quiver([0 0],[h(i) h(i)],[2^.5/2*cos(theta(i)) 2^.5/2*sin(theta(i))],[-2^0.5/2*sin(theta(i)) 2^0.5/2*cos(theta(i))],'g','LineWidth',1.5) %frame B

    %grafico los np
    plot([RnpN(1,:,i)],[RnpN(2,:,i)],'k','marker','s');

    %grafico los vp
    plot([RvpN(1,:,i)],[RvpN(2,:,i)],'g','marker','o');

    %grafico los cp
    plot([RcpN(1,:,i)],[RcpN(2,:,i)],'r','marker','x');

    %grafico los vectores normales
    quiver(RcpN(1,:,i),RcpN(2,:,i),normal_N(1,:,i),normal_N(2,:,i));
    
    %axis equal
    axis([-1.5*b 1.5*b -A-b A+b]);
    title('animacion de placa 2D'), xlabel('x'), ylabel('y')
    grid on;  
    M(i)=getframe;
    hold off
end
movie(M)
%--------------------------------------------------------------------------







        