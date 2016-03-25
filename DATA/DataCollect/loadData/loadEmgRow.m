 function row = loadEmgRow(filePath)
%loadEmgRow is used to find the row number of sEMG data from ASC files outputing by
%MegaWin.
%%
%filePath='G:\SNARC\DATA\患者组\张爱民\右手偏\肌电\zam-motionR1-3.ASC';
%Read the data from file.
fid = fopen(filePath);
row=0;
while ~feof(fid)
    % 一次性读取10000字符，计算其中的回车个数，其中10是回车的ASCII编码
    % '*char'表示每次读取一个字符，*表示输出也是字符
    % 放心fread现在已经可以自动识别中文了，万一还是识别不了，
    % 请在fopen中指定文件编码格式，比如gbk
    row=row+sum(fread(fid,10000,'*char')==char(10));
    % 下面还有一个类似的方法，但是效率低很多，大概是上面的一半
    % 'char'表示每次读取一个字符，但是默认输出double，
    % 也就是说读取char然后转换double中间有转换能快吗？
    % row=row+sum(fread(fid,10000,'char')==10);
end
row=row-52;
fclose(fid);
