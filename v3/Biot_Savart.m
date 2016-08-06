function v_ind=Biot_Savart(x,y,x0,y0,G,cutoff)
%calcula la velocidad inducida en el punto x por un vórtice 2D con circulación G
%ubicado en x0
rsq=(x-x0)^2+(y-y0)^2;
rsq=max(rsq,cutoff);
v_ind=G/2/pi/rsq*[0 1 ;-1 0]*[x-x0; y-y0];