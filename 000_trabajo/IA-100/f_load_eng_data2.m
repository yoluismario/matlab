function eng_data = f_load_eng_data2(filename,startRow)
% eng_data = f_load_eng_data(filename,startRow)
% Carga los datos de los archivos de motor según el formato corregido.
% Un ejemplo de filename es: 'prop_data\xxxx.txt'
% Llamando el archivo xxxx.txt dentro de la carpeta prop_data
delimiter = '\t';
% startRow = 3;
formatSpec = '%*s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);
eng_data = [dataArray{1:end-1}];
end