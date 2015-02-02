close all;
clear;
clc;
%%
quatU{1}=load('U\Quad13.txt');
quatU{2}=load('U\Quad14.txt');
quatU{3}=load('U\Quad15.txt');
quatA{1}=load('A\Quad13.txt');
quatA{2}=load('A\Quad14.txt');
quatA{3}=load('A\Quad15.txt');

for i=1:3
    [scaleA{i} axisA{i}]=quatfac(quatA{i});
    [scaleU{i} axisU{i}]=quatfac(quatU{i});
end

Name={'´ó±Û','Ð¡±Û','ÊÖ'}
for i=1:3
    figure('Name', Name{i});
    text(0,0,Name(i));
    subplot(2,2,1)
    plot(scaleA{i});
    title('»¼ÕßÐý×ª½Ç');
    subplot(2,2,3)
    plot(scaleU{i});
    title('½¡¿µÐý×ªÖá');
    subplot(2,2,2)
    plot(axisA{i});
    title('»¼ÕßÐý×ª½Ç');
    subplot(2,2,4)
    plot(axisU{i});
    title('½¡¿µÐý×ªÖá');
    
end
