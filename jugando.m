
f_test=@(x)sin(x)+exp(-x);
f_t=@(t)sin(t);
dt = 1/100;
clf
for t=0:dt:3
    x1 = 0.1;% i/10;
    x2 = 1.6;% x1+1.5;
    x =linspace(x1,x2);
    hold on
    %plot(f_test(x),x+i/100)
    
    xlim([0 3]); ylim([0 1]);
    fg = plot(t,f_t(t),'*');
    F = getframe(gca);
    pause(0.01)
end
