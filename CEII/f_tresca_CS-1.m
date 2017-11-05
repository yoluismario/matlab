function sigma_comp = f_tresca_CS(sigma_y,sigma_z,tau_xy)
A = (sigma_z+sigma_y)/2;
R = sqrt(((sigma_z+sigma_y)/2)^2+tau_xy^2);

if abs(A)<=R
    sigma_comp = 2*R;
else
    sigma_comp = abs(A)+R;
end

end