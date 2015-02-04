close all;
clear;
clc;
%%
load('../DATA/dataSetA');
load('../DATA/dataSetU');
PART = 1;
for i=1:length(dataSetA.name)
    for j=1:4
        [A(i).angA{j} A(i).axisA{j}]=quatfac(dataSetA.quat(i).limb{j});
    end    
end

for i=1:length(dataSetU.name)
    for j=1:4
        [U(i).angU{j} U(i).axisU{j}]=quatfac(dataSetU.quat(i).limb{j});
    end
end

figure;
for i=1:length(dataSetA.name)
    subplot(6,4,i)
    plot(A(i).angA{PART});
    ylim([0 90]);
end

figure;
for i=1:length(dataSetU.name)
    subplot(4,3,i)
    plot(U(i).angU{PART});
    ylim([0 90]);
end
% Name={'Ñü','´ó±Û','Ð¡±Û','ÊÖ'}
% for i=1:4
%     figure('Name', Name{i});
%     text(0,0,Name(i));
%     subplot(2,2,1)
%     plot(scaleA{i});
%     title('»¼ÕßÐý×ª½Ç');
%     subplot(2,2,3)
%     plot(scaleU{i});
%     title('½¡¿µÐý×ªÖá');
%     subplot(2,2,2)
%     plot(axisA{i});
%     title('»¼ÕßÐý×ª½Ç');
%     subplot(2,2,4)
%     plot(axisU{i});
%     title('½¡¿µÐý×ªÖá');
%     
% end
