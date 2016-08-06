function [v_w_cp, RHS]=Vind_sobre_est( rcp, rvpw, G_W, nV,  nelw )

global   nel V_inf

v_w_cp=zeros(2,nel);%velocidad en los CP de la placa inducida por la estela


%velocidad inducida por la estela sobre el ala
    for j=1:nel
        for i=1:nelw
        v_w_cp(:,j)=v_w_cp(:,j)+Biot_Savart(rcp(1,j), rcp(2,j), rvpw(1, i),rvpw(2, i), G_W(i),1e-6); 
        end
        
%         VV_w_cp(:,j,k+1)=v_w_cp(:,j);
    end
    
    nvw=nV'*v_w_cp(:,:);
%solución para las circulaciones   
RHS(1:n_el)=-nV'*V_inf-nvw(1:n_el);
RHS(n_el+1)=RHS(n_el+1)-G_W(n_elw);



