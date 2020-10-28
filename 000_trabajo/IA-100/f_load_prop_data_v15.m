function prop_data = f_load_prop_data_v15(filename,startRow)
% prop_data = f_load_prop_data(filename,startRow)
% Carga los datos de los archivos de helice según el formato corregido.
% Un ejemplo de filename es: 'prop_data\CT(M=0.975).txt'
% Llamando el archivo CT(...).txt dentro de la carpeta prop_data
delimiter = '\t';
% startRow = 2;
formatSpec = '%*s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);
% clearvars filename delimiter startRow formatSpec fileID dataArray ans;
prop_data = [dataArray{1:end-1}];
end