x=0:.001:5; y=0:0.001:5;
for i=1:length(x)
    
v(i)=norm(Biot_Savart(x(i), y(i), 0,0,1,1e-1));
end


figure(2)
plot(x, v)