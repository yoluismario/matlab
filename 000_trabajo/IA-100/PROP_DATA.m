function [eta,CT,beta,J_v,Cp_v,M_tip_v] = PROP_DATA()
%-----------LECTURA DE DATOS DE HÉLICE HARTZELL-----------

%----NOTAS DEL SCRIPT---

% VERSIÓN INICIAL - 2017-05-08 - M. Tejeda
%   Script de importación de datos autogenerado.
%   Las variables se definen en función de los parámetros de entrada de
% Hartzell Inc.
%   Los vectores CP, J y MTIP deben ser definidos en función de los mapas
% de hélices provistos
%   Las variables CT, beta y eta se almacenan en arreglos en los cuáles
% cada fila corresponde a un valor de CP, cada columna a uno de J y cada
% página a un MTIP.
%   Los archivos importados deben estar en formato de texto plano, según el
%   formato de los archivos de ejemplo.

%%%%% Vectores CP, J, MTIP  %%%%%
J_v = 0:0.1:2.9;
Cp_v = 0.02:0.01:0.5;
M_tip_v = [0.5	0.6	0.7 0.8 0.9 0.95 .975];

%% %%%%%%%%%%%%%%%%%% CARGA DE beta %%%%%%%%%%%%%%%%%%%%
startRow = 2;
%%%%% M=0.500 %%%%%
beta(:,:,1) = f_load_prop_data_v15('prop_data/beta(M=0.500).txt',startRow);
%%%%% M=0.600 %%%%%
beta(:,:,2) = f_load_prop_data_v15('prop_data/beta(M=0.600).txt',startRow);
%%%%% M=0.700 %%%%%
beta(:,:,3) = f_load_prop_data_v15('prop_data/beta(M=0.700).txt',startRow);
%%%%% M=0.800 %%%%%
beta(:,:,4) = f_load_prop_data_v15('prop_data/beta(M=0.800).txt',startRow);
%%%%% M=0.900 %%%%%
beta(:,:,5) = f_load_prop_data_v15('prop_data/beta(M=0.900).txt',startRow);
%%%%% M=0.950 %%%%%
beta(:,:,6) = f_load_prop_data_v15('prop_data/beta(M=0.950).txt',startRow);
%%%%% M=0.975 %%%%%
beta(:,:,7) = f_load_prop_data_v15('prop_data/beta(M=0.975).txt',startRow);

%% %%%% Carga de CT %%%%%

%%%%% M=0.500 %%%%%
CT(:,:,1) = f_load_prop_data_v15('prop_data/CT(M=0.500).txt',startRow);
%%%%% M=0.600 %%%%%
CT(:,:,2) = f_load_prop_data_v15('prop_data/CT(M=0.600).txt',startRow);
%%%%% M=0.700 %%%%%
CT(:,:,3) = f_load_prop_data_v15('prop_data/CT(M=0.700).txt',startRow);
%%%%% M=0.800 %%%%%
CT(:,:,4) = f_load_prop_data_v15('prop_data/CT(M=0.800).txt',startRow);
%%%%% M=0.900 %%%%%
CT(:,:,5) = f_load_prop_data_v15('prop_data/CT(M=0.900).txt',startRow);
%%%%% M=0.950 %%%%%
CT(:,:,6) = f_load_prop_data_v15('prop_data/CT(M=0.950).txt',startRow);
%%%%% M=0.975 %%%%%
CT(:,:,7) = f_load_prop_data_v15('prop_data/CT(M=0.975).txt',startRow);

%% %%%% Carga de eta %%%%%

%%%%% M=0.500 %%%%%
eta(:,:,1) = f_load_prop_data_v15('prop_data/eta(M=0.500).txt',startRow);
%%%%% M=0.600 %%%%%
eta(:,:,2) = f_load_prop_data_v15('prop_data/eta(M=0.600).txt',startRow);
%%%%% M=0.700 %%%%%
eta(:,:,3) = f_load_prop_data_v15('prop_data/eta(M=0.700).txt',startRow);
%%%%% M=0.800 %%%%%
eta(:,:,4) = f_load_prop_data_v15('prop_data/eta(M=0.800).txt',startRow);
%%%%% M=0.900 %%%%%
eta(:,:,5) = f_load_prop_data_v15('prop_data/eta(M=0.900).txt',startRow);
%%%%% M=0.950 %%%%%
eta(:,:,6) = f_load_prop_data_v15('prop_data/eta(M=0.950).txt',startRow);
%%%%% M=0.975 %%%%%
eta(:,:,7) = f_load_prop_data_v15('prop_data/eta(M=0.975).txt',startRow);
end