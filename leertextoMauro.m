i = 0
fid = fopen('nof')

tline = fgetl(fid);
while ischar(tline)
  wordsP = textscan(tline,'%s %f %s', 'Delimiter', '=', 'Delimiter', ' ','MultipleDelimsAsOne', 1 ) % cell con tres elementos
  wordP = wordsP{1}; % debe tener la palabra peso
  if( strcmp('peso',word{1})
    tline = fgetl(fid);
    wordsV = textscan(tline,'%s %f %s', 'Delimiter', '=', 'Delimiter', ' ','MultipleDelimsAsOne', 1 ) % cell con tres elementos
    wordV = wordsV{1}; % debe tener la palabra Vopt
    if( strcmp('Vopt',word{1})
      i = i + 1

      datos(1,i) = wordsP{2}
      datos(2,i) = wordsV{2}

      tline = fgetl(fid);
      wordsW = textscan(tline,'%s %f %s', 'Delimiter', '=', 'Delimiter', ' ','MultipleDelimsAsOne', 1 ) % cell con tres elementos
      wordW = wordsW{1}; % debe tener la palabra Wopt
      datos(3,i) = wordsW{2}
    end
  end
  tline = fgetl(fid);
end
close(fid)