function torque = f_load_torque(filename,startRow)
% eng_data = f_load_eng_data(filename,startRow)
% Carga los datos de los archivos de motor según el formato corregido.
% Un ejemplo de filename es: 'prop_data\xxxx.txt'
% Llamando el archivo xxxx.txt dentro de la carpeta prop_data
delimiter = '\t';
startRow = 4;
formatSpec = '%*s%*s%*s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen('Torque-T.O.-M.C.P..txt','r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);
torque = [dataArray{1:end}];
end