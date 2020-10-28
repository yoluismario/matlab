%-----------GENERACIÓN DE BANCO MOTOR PARA MOTORES DE HÉLICE-----------
% ENG_DECK('nombre_archivo_salida.txt', DELTA_ISA en K)
%----NOTAS DEL SCRIPT----
%VERSIÓN INICIAL - 2017/04/05 - M. Tejeda
%   - Modelo limitado hasta 20000m en ISA.
% versión 2020 
% actualizadas las funciones de lectura de datos

function ENG_DECK(DELTA_ISA)

% Ingreso de variables de cálculo

% velocidades = [60:15:195]; % Velocidades en [KTAS]

Machs_step = 0.03 ;
Machs = [0.03:Machs_step:0.3]; % Números de Mach [-]
% Alturas en [ft] la altura debe ir en metros[m]
 alturas = [0:2000:10000]*0.3048; 
 d = 1.9304; %diámetro de hélice en [m]
 
% Unidades de salida: (THRUST)
% EMPUJE:             2= lb y kts/Mach
%                     0 = kgf y Km/h / Mach
%                     1 = daN y Km/h / Mach
% Unidades de salida: (CONSUM)
% CONSUMO:            2= lb/h  y kts/Mach
%                     0 = kg/h y Km/h / Mach
%                     1 = daN/h y Km/h / Mach
% por defecto está programado en lb y Mach:
unid = 2;

% Lectura de datos de hélice y motor
% PROP_DATA: levanta los archivos de la hélice
% ENG_DATA: levanta los datos de motor
[beta CT eta] = PROP_DATA();
[RPM PLA PRESALT ENG_PWR ENG_FF ] = ENG_DATA(DELTA_ISA);
THRUST();

end 