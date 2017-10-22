function tensiones = f_tensiones_elemento(eps,E,nu)
mat = E/(1-nu^2)*[1 nu 0;nu 1 0; 0 0 1-nu];
tens = mat*eps';
S_vm =(tens(1)^2+tens(2)^2-tens(1)*tens(2)+3*tens(3)^2)^.5;
tensiones = [tens(1) tens(2) tens(3) S_vm];
end

