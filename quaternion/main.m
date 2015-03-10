close all;
clear;
clc;
%%
load('../DATA/dataSetA');
load('../DATA/dataSetU');
PART = 2;
%% glb2body 
% PART = 2;
% for i=1:length(dataSetA.name)
%     for j=1:4
% %         dataSetA.quat(i).limb{2}=quatdivide(dataSetA.quat(i).limb{1},dataSetA.quat(i).limb{2});
%         dataSetA.quat(i).limb{2}=quatmultiply(quatinv(dataSetA.quat(i).limb{1}),dataSetA.quat(i).limb{2});
%     end    
% end
% 
% for i=1:length(dataSetU.name)
%     for j=1:4
% %         dataSetU.quat(i).limb{2}=quatdivide(dataSetU.quat(i).limb{1},dataSetU.quat(i).limb{2});
%         dataSetU.quat(i).limb{2}=quatmultiply(quatinv(dataSetU.quat(i).limb{1}),dataSetU.quat(i).limb{2});
%     end    
% end

%%
for i=1:length(dataSetA.name)
    if ~isempty(dataSetA.quat(i).limb)
        for j=1:4
            [A(i).angA{j} A(i).axisA{j}]=quatfac(dataSetA.quat(i).limb{j});
        end    
        Sh.A.ang.ton{i}=A(i).angA{PART}(dataSetA.loc0(i) : dataSetA.loc1(i));
        Sh.A.ang.met{i}=A(i).angA{PART}(dataSetA.loc1(i) : end);
        Sh.A.axis.ton{i}=A(i).axisA{PART}(dataSetA.loc0(i) : dataSetA.loc1(i),:);
        Sh.A.axis.met{i}=A(i).axisA{PART}(dataSetA.loc1(i) : end,:);
        
        Tru.A{i} = A(i).angA{1};
    end
end

Sh.A.FM = dataSetA.FM;

for i=1:length(dataSetU.name)
    for j=1:4
        [U(i).angU{j} U(i).axisU{j}]=quatfac(dataSetU.quat(i).limb{j});

    end
    Sh.U.ang.ton{i}=U(i).angU{PART}(dataSetU.loc0(i) : dataSetU.loc1(i));
    Sh.U.ang.met{i}=U(i).angU{PART}(dataSetU.loc1(i) : end);
    Sh.U.axis.ton{i}=U(i).axisU{PART}(dataSetU.loc0(i) : dataSetU.loc1(i),:);
    Sh.U.axis.met{i}=U(i).axisU{PART}(dataSetU.loc1(i) : end,:);
    
    Tru.U{i} = U(i).angU{1};
end



figure;
for i=1:length(dataSetA.name)
    if ~isempty(dataSetA.quat(i).limb)
        subplot(5,7,i)
        plot(A(i).angA{PART}/90);
        hold on;
        plot([dataSetA.loc1(i) dataSetA.loc1(i)],[0 1],'--m');
        plot([dataSetA.loc0(i) dataSetA.loc0(i)],[0 1],'--k');
        ylim([0 1]);
    end   
    title(['FM=' num2str(dataSetA.FM(i))]);
end

figure;
for i=1:length(dataSetA.name)
    if ~isempty(dataSetA.quat(i).limb)
        subplot(5,7,i)
        plot(A(i).axisA{PART});
        hold on;
        plot([dataSetA.loc1(i) dataSetA.loc1(i)],[-1 1],'--m');
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
    plot([dataSetU.loc1(i) dataSetU.loc1(i)],[0 1],'--m');
    plot([dataSetU.loc0(i) dataSetU.loc0(i)],[0 1],'--k');
    ylim([0 1]);
end

figure;
for i=1:length(dataSetU.name)
    subplot(4,3,i)
    plot(U(i).axisU{PART});
    hold on;
    plot([dataSetU.loc1(i) dataSetU.loc1(i)],[-1 1],'--m');
    plot([dataSetU.loc0(i) dataSetU.loc0(i)],[-1 1],'--k');
    ylim([-1 1]);
end    

figure;
for i=1:length(dataSetA.name)
    subplot(5,7,i)
    plot(Tru.A{i}/90);
    ylim([0 1]);
end

figure;
for i=1:length(dataSetU.name)
    subplot(4,3,i)
    plot(Tru.U{i}/90);
    ylim([0 1]);
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

