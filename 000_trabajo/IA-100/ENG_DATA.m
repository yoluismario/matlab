function [RPM,PLA,PRESALT,ENG_PWR,ENG_FF] = ENG_DATA(DELTA_ISA)
%-----------LECTURA DE DATOS MOTOR-----------

%----NOTAS DEL SCRIPT---

% VERSIÓN INICIAL - 2017-05-08 - M. Tejeda
%   Script de importación de datos autogenerado.
%   Las variables se definen en función de los parámetros de entrada de
% Hartzell Inc.
%   Los vectores PLA, RPM y PRESALT deben ser definidos en función de los
%   datos de motor
%   Las variables CT, beta y eta se almacenan en arreglos en los cuáles
% cada fila corresponde a un valor de CP, cada columna a uno de J y cada
% página a un MTIP.
%   Los archivos importados deben estar en formato de texto plano, según el
%   formato de los archivos de ejemplo.

%%%%% POSICIONES DE PALANCA %%%%%

% Seleccionar según BEST POWER o BEST ECONOMY

%BEST ECONOMY
%PLA = [0.41 0.45 0.51 0.56 0.61 0.68 0.75 0.83 0.93 1.0];
PLA = [0.41 0.45 0.51 0.56 0.61 0.68 0.71 0.75 0.79 0.83 0.93 1.0];
%RPM = [1800:100:2700];
RPM = [1800 1900 2000 2100 2200 2300 2350 2400 2450 2500 2600 2700];


%BEST POWER
%PLA = [0.61 0.68 0.75 0.83 0.93 1.0];
PLA = [0.61 0.68 0.71 0.75 0.79 0.83 0.93 1.0];

%RPM = [2200:100:2700];
RPM = [2200 2300 2350 2400 2450 2500 2600 2700];


PRESALT = [0:1000:24000];% en pies [ft]

%%%%% POTENCIA DE MOTOR %%%%%

% Seleccionar archivo según BEST POWER o BEST ECONOMY
%filename = 'LY-IO-360-B_PWR_BP.txt';
ENG_PWR = f_load_eng_data_v15('prop_data/LY-IO-360-B_PWR_BP.txt',3);

% modificacion por ISA
%DELTA_ISA = 25;
ISA_coef = sqrt((460+15*1.8)/(460+(15+DELTA_ISA)*1.8));
ENG_PWR = ISA_coef*ENG_PWR;

%%%%% CONSUMO DE MOTOR %%%%%
% Seleccionar archivo según BEST POWER o BEST ECONOMY
%filename = 'Y:\PROYECTOS\IA 74\Antecedentes_Física del Vuelo_IA100\Datos de hélice\LY-IO-360-B_FF_BP.txt';
ENG_FF =  f_load_eng_data_v15('prop_data/LY-IO-360-B_FF_BP.txt',3);
end