function res=  colebrookf(f, V,  nu, D, rug)

Re=V*D/nu;

res= f-0.25/(log10(rug/D/3.7+2.51/Re/sqrt(f)))^2;