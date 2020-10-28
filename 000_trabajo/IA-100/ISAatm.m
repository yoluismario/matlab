%-----------CÁLCULO DE PARÁMETROS DE PARA ATMÓSFERA ESTÁNDAR-----------

%----NOTAS DEL SCRIPT----
%VERSIÓN INICIAL - 2017/04/05 - M. Tejeda
%   - Modelo ISA limitado hasta 20000m en ISA.
% Correcciones - 2017/07/12 - Luis Soria-Castro
% funciona el Delta ISA

function [ TempK, press, rho, snd_spd, mu ] = ISAatm( alt_press, DeltaT )
%alt_press = 9000*0.3048; DeltaT = -10;
% press    [Pa]
% TempK    [K]
% rho      [kg/m³]
% snd_spd  [m/s]
% mu       [Ns/m²]
% alt_press [m] ALTURA a la que se requieren datos, o altura de presion
% DeltaT   [K]

g0 = 9.80665; %Aceleración de la gravedad
Raire = 287.05287; %Constante para el aire
gradT = 0.0065; %Gradiente de temperatura para altitude<11000m
T0m = 288.15; %Temperatura a nivel del mar en ISA en [K]
P0m = 101325; %Presión atmosférica a nivel del mar
gamma = 1.4; %Coeficiente Adiabático
%rho0m = P0m/(Raire*(T0m+DeltaT)); %Densidad a nivel del mar
%Temperatura
if alt_press<=11000
    TempK = T0m+DeltaT-gradT*alt_press;
else
    TempK = 216.65+DeltaT;
end
%Presión
if alt_press<=11000
   press = P0m*((TempK-DeltaT)/T0m)^(g0/(gradT*Raire));
else
   press = P0m*((TempK-DeltaT)/(T0m+DeltaT))^(g0/(gradT*Raire))*exp(-g0*(alt_press-11000)/(Raire*216.65));
end
%Densidad
rho = press/(Raire*TempK);
%Velocidad del sonido
snd_spd = (gamma*Raire*TempK)^0.5;
%Viscosidad Dinámica
mu = (1.458e-6*TempK^1.5)/(TempK+110.4);

ISA_VAL=[ TempK, press, rho, snd_spd, mu ];

% clearvars g0 Raire gradT T0m P0m gamma pressalt TempK DeltaT press rho
% clearvars snd_spd mu

% FIN DE LA FUNCIÓN
end

