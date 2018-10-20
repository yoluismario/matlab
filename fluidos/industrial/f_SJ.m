% factor de friccion de Darcy para flujo totalmente desarrollado,
% formula explicita aproximada de Swamee & Jain.
% f=  f_SJ(V, nu, D, rug)
function f=  f_SJ(V, nu, D, rug)

Re=V*D/nu;

f0=0.25/(log10((rug/D)/3.7+5.74/Re^.9))^2
f = 0.25/(log10((rug/D)/3.7+2.51/(Re*sqrt(f0))))^2