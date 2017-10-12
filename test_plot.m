% guardar una figura en un archivo

x = -pi:pi/10:pi;
y = -pi:pi/2;

plot(x,cos(x),x,sin(x));
% imwrite(A,'newImage.jpg','jpg','Comment','My JPEG file')
% bar(1:10)
print('barPlot','-dpng')