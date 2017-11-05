function res=  colebrookV(V,hf, f, g, nu,L, D, rug)



res=hf- (0.25/(log10(rug/D/3.7+2.51*nu/V/D/sqrt(f)))^2)*...
    V^2/2/g*L/D;