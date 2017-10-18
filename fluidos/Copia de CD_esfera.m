function CD_esf = CD_esfera(Re)

if Re =< 1
	CD_esf = 24/Re;
elseif 1< Re =< 400
	CD_esf = 24/(Re^0.646);
elseif 400  < Re =< 3e6
	CD_esf =0.5;
else 
	CD_esf = 0.18;
end