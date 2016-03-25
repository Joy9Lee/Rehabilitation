function emgData = loadEmg(filePath)
%loadEmg is used to load the sEMG matrix from ASC files outputing by
%MegaWin.
%%
%filePath='G:\SNARC\DATA\HealthL\dlq.ASC';
%filePath='G:\SNARC\DATA\HealthL\cgc.ASC';
%Read the data from file.
fid = fopen(filePath);
emgData = fscanf(fid,'%c');
fclose(fid);
%Extract the sEMG matrix
i = findstr(emgData,'[DATA]');
emgData = emgData(i+6:end);
emgData = str2num(emgData);