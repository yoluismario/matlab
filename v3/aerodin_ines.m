function [V_wp, V_vp_w, v_w_cp]=aerodin_ines( rcp, Gw,nelw, k )

global  alpha theta nsteps b  a  h nel V_inf

v_w_cp(:,j)
%velocidad inducida por la estela sobre el ala
    for j=1:nel
        for i=1:nelw
        v_w_cp(:,j)=v_w_cp(:,j)+Biot_Savart(rcp(1,j), rcp(2,j), rvpw(1, i),rvpw(2, i), G_W(i),1e-6); 
        end
        
%         VV_w_cp(:,j,k+1)=v_w_cp(:,j);
    end
    
    NV=kron(ones(1,n_el), nV);
    nvw=dot(NV,v_w_cp(:,:, k+1));
%solución para las circulaciones   
RHS(1:n_el)=-nV'*Vinf-nvw(1:n_el);
RHS(n_el+1)=RHS(n_el+1)-G_W(n_elw);



for j=1:nelw% calcula la influencia de cada elemento
 %% velocidades "inducidas" en segmentos de la estela por la placa
    for i=1:nel  %en el vortex piont convectado de la estela
    V_vp_w(:,j)=V_vp_w(:,j)+Biot_Savart(RvpW_old(1,j),RvpW_old(2,j), RvpN(1,i),RvpN(2,i), G(i),coff);
    end
    %% velocidades "inducidas" en segmentos de la estela por la estela
    for i=1:nelw
    V_w_w(:,j)=V_w_w(:,j)+Biot_Savart(RvpW_old(1,j),RvpW_old(2,j), RvpW_old(1,i),RvpW_old(2,i), G_w(i,k),coff);
    end
    %velocidad total en la estela
    V_wp(:,j)=V_inf+V_vp_w(:, j)+V_w_w(:,j);
    %V_wp(2,j)=V_inf*sin(theta)+V_w_w(2,j)+V_vp_w(2, j);
end
%% velocidades "inducidas" en  la placa por la estela

    for i=1:nel% calcula la influencia de cada elemento de la estela
        for  j=1:nelw %en el control point de la paca
        V_w_cp(:,i)=V_w_cp(:,i)+Biot_Savart(RcpN(1,i),RcpN(2,i), RvpW_old(1,j),RvpW_old(2,j), G_w(j,k),coff);%
        end
    end
    
    V_infn=V_inf'*normalsN(:,:);

for i=1:nel
    
RHS(i)=-normalsN(:,i)'*V_w_cp(:, i)-V_infn(i);
end
