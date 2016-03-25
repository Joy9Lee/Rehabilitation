 function row = loadEmgRow(filePath)
%loadEmgRow is used to find the row number of sEMG data from ASC files outputing by
%MegaWin.
%%
%filePath='G:\SNARC\DATA\������\�Ű���\����ƫ\����\zam-motionR1-3.ASC';
%Read the data from file.
fid = fopen(filePath);
row=0;
while ~feof(fid)
    % һ���Զ�ȡ10000�ַ����������еĻس�����������10�ǻس���ASCII����
    % '*char'��ʾÿ�ζ�ȡһ���ַ���*��ʾ���Ҳ���ַ�
    % ����fread�����Ѿ������Զ�ʶ�������ˣ���һ����ʶ���ˣ�
    % ����fopen��ָ���ļ������ʽ������gbk
    row=row+sum(fread(fid,10000,'*char')==char(10));
    % ���滹��һ�����Ƶķ���������Ч�ʵͺܶ࣬����������һ��
    % 'char'��ʾÿ�ζ�ȡһ���ַ�������Ĭ�����double��
    % Ҳ����˵��ȡcharȻ��ת��double�м���ת���ܿ���
    % row=row+sum(fread(fid,10000,'char')==10);
end
row=row-52;
fclose(fid);
