function v_ind=Biot_Savart(x,y,x0,y0,G,cutoff)

rsq=(x-x0)^2+(y-y0)^2;
rsq=max(rsq,cutoff);
v_ind=G/2/pi/rsq*[0 1 ;-1 0]*[x-x0; y-y0];