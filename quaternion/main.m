close all;
% clear;
% clc;
%%
% load('../DATA/testA');
load('../DATA/11DataU');
PART = 2;
for i=1:length(dataSetA.name)
    if ~isempty(dataSetA.quat(i).limb)
        for j=1:4
            [A(i).angA{j} A(i).axisA{j}]=quatfac(dataSetA.quat(i).limb{j});
        end    
    end
end

for i=1:length(dataSetU.name)
    for j=1:4
        [U(i).angU{j} U(i).axisU{j}]=quatfac(dataSetU.quat(i).limb{j});
    end
end

figure;
for i=1:length(dataSetA.name)
    if ~isempty(dataSetA.quat(i).limb)
        subplot(8,5,i)
        plot(A(i).angA{PART}/90);
        ylim([0 1]);
    end   
    title(num2str(dataSetA(i).FM));
end

figure;
for i=1:length(dataSetA.name)
    if ~isempty(dataSetA.quat(i).limb)
        subplot(8,5,i)
        plot(A(i).axisA{PART});
        ylim([-1 1]);
    end
    title(num2str(dataSetA(i).FM));
end


figure;
for i=1:length(dataSetU.name)
    subplot(4,3,i)
    plot(U(i).angU{PART}/90);
    ylim([0 1]);
end

figure;
for i=1:length(dataSetU.name)
    subplot(4,3,i)
    plot(U(i).axisU{PART});
    ylim([-1 1]);
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
