function res=  Swamie_Jain(V,hf, g, nu,L, D, rug)

Re=V*D/nu;

res=hf- (0.25/(log10(rug/D/3.7+5.74/Re^.9))^2)*...
    V^2/2/g*L/D;