function main()
close all;
% clear;
% clc;
%%
load('../DATA/dataSetA');
load('../DATA/dataSetU');
PART = 2;
for i=1:length(dataSetA.name)
    if ~isempty(dataSetA.quat(i).limb)
        for j=1:4
            [A(i).angA{j} A(i).axisA{j}]=quatfac(dataSetA.quat(i).limb{j});
%             index = markStart(A(i).angA{j});
%             dataSetA.loc0(i)=index;
        end    
    end
end

for i=1:length(dataSetU.name)
    for j=1:4
        [U(i).angU{j} U(i).axisU{j}]=quatfac(dataSetU.quat(i).limb{j});
%         index = markStart(U(i).angU{j});
%         dataSetU.loc0(i)=index;
    end
end

figure;
for i=1:length(dataSetA.name)
    if ~isempty(dataSetA.quat(i).limb)
        subplot(7,5,i)
        plot(A(i).angA{PART}/90);
        hold on;
        plot([dataSetA.loc(i) dataSetA.loc(i)],[0 1],'--m');
        plot([dataSetA.loc0(i) dataSetA.loc0(i)],[0 1],'--k');
        ylim([0 1]);
    end   
    title(['FM=' num2str(dataSetA.FM(i))]);
end

figure;
for i=1:length(dataSetA.name)
    if ~isempty(dataSetA.quat(i).limb)
        subplot(8,5,i)
        plot(A(i).axisA{PART});
        hold on;
        plot([dataSetA.loc(i) dataSetA.loc(i)],[-1 1],'--m');
        plot([dataSetA.loc0(i) dataSetA.loc0(i)],[-1 1],'--k');
        ylim([-1 1]);
    end
    title(['FM=' num2str(dataSetA.FM(i))]);
end


figure;
for i=1:length(dataSetU.name)
    subplot(4,3,i)
    plot(U(i).angU{PART}/90);
    hold on;
    plot([dataSetU.loc(i) dataSetU.loc(i)],[0 1],'--m');
    plot([dataSetU.loc0(i) dataSetU.loc0(i)],[0 1],'--k');
    ylim([0 1]);
end

figure;
for i=1:length(dataSetU.name)
    subplot(4,3,i)
    plot(U(i).axisU{PART});
    hold on;
    plot([dataSetU.loc(i) dataSetU.loc(i)],[-1 1],'--m');
    plot([dataSetU.loc0(i) dataSetU.loc0(i)],[-1 1],'--k');
    ylim([-1 1]);
end    
% Name={'Ñü','´ó±Û','Ğ¡±Û','ÊÖ'}
% for i=1:4
%     figure('Name', Name{i});
%     text(0,0,Name(i));
%     subplot(2,2,1)
%     plot(scaleA{i});
%     title('»¼ÕßĞı×ª½Ç');
%     subplot(2,2,3)
%     plot(scaleU{i});
%     title('½¡¿µĞı×ªÖá');
%     subplot(2,2,2)
%     plot(axisA{i});
%     title('»¼ÕßĞı×ª½Ç');
%     subplot(2,2,4)
%     plot(axisU{i});
%     title('½¡¿µĞı×ªÖá');
%     
% end

function index = markStart(ang)
%mark the index of motion start
for i = 1:length(ang)
    index = 200;
    if ang(i)>20
       index = i;
        break;
    end
end