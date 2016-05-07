function S_vm=von_mises(tens)
    S_vm =(tens(1)^2+tens(2)^2-tens(1)*tens(2)+3*tens(3)^2)^.5;
end
