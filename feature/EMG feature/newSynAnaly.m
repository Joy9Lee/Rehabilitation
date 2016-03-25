close all; clear ; clc;
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
addpath('../../SignalProcess');
addpath('../../quaternion')
addpath('../../feature')
fs=50;
for i=1:length(SynDataA.name)
    
    angA{i}=SynDataA.elbAng{i}/90;
    iEMGA{i}=CiEMG(SynDataA.EMG{i},20);
    powRatio{i}=iEMGA{i}(:,5)./iEMGA{i}(:,6);
    %powRatio{i}=linear_normalize(powRatio{i});
    mA(i)=max(powRatio{i});
    %     subplot(4,6,i)
    %     L(i)=min(length(angA{i}),length(SynDataA.synEMG{i}));
    %     t=(1:L(i))/fs;
    %     plot(t,angA{i}(1:L(i)))
    %     hold on
    %     plot(t,powRatio{i}(1:L(i)))
    %     [r(i),p(i)]=corrAnaly(angA{i}(1:L(i))','Fugl-Meyer∆¿∑÷',powRatio{i}(1:L(i)),'logVAR',0);
    
end
%suptitle('affected Bice/Trice PowerRatio')
for i=1:length(SynDataU.name)
    
    angU{i}=SynDataU.elbAngR{i}/90;
    iEMGU{i}=CiEMG(SynDataU.EMGR{i},20);
    powRatioU{i}=iEMGU{i}(:,5)./iEMGU{i}(:,6);
    mU(i)=max(powRatioU{i});
    %powRatioU{i}=linear_normalize(powRatioU{i});
    
    %     subplot(4,6,i)
    %     LU(i)=min(length(angU{i}),length(SynDataU.synEMG{i}));
    %     tU=(1:LU(i))/fs;
    %     plot(tU,angU{i}(1:L(i)))
    %     hold on
    %     plot(tU,powRatioU{i})
    %     [r(i),p(i)]=corrAnaly(angU{i}(1:LU(i))','Fugl-Meyer∆¿∑÷',powRatioU{i}(1:LU(i)),'logVAR',0);
    
end



for i=1:length(SynDataA.name)
    figure
    lA=length(angA{i});
    lE=length(iEMGA{i});
    L(i)=min(lA,lE);
    t=(1:L(i))/fs;
    plot(t,angA{i}(1:L(i)),'r')
    xlabel('Time/s')
    hold on
    plot(t,powRatio{i}(1:L(i))/25)
   % set(gcf,'Position',get(0,'ScreenSize'))
    title(strcat('FM=',num2str(SynDataA.FM(i)),SynDataA.name{i}));
    %title(SynDataA.name{i});
    legend('Elbow Angle','Bice/Trice PowerRatio')
    ylim([0 1])
end





for i=1:length(SynDataU.name)
    figure
    lA=length(angU{i});
    lE=length(iEMGU{i});
    L(i)=min(lA,lE);
    t=(1:L(i))/fs;
    plot(t,angU{i}(1:L(i)),'r')
    xlabel('Time/s')
    hold on
    plot(t,powRatioU{i}(1:L(i))/25)
    % title(strcat('FM=',num2str(SynDataA.FM(i)),SynDataA.name{i}));
   
    title(SynDataU.name{i});
    legend('Elbow Angle','Bice/Trice PowerRatio')
    ylim([0 1])
end
% figure
% plot(r,'*')