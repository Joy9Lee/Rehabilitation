close all
clear all
clc
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');
addpath('../../signalProcess')
fs=50;
for i=1:length(SynDataA.EMG)
    SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
    SynDataA.mvc{i}=EMGPre(SynDataA.mvc{i});
    %pmvc{i}=max(winMean(SynDataA.mvc{i},100));
    
    
    rmvc{i}=max(winRMS(SynDataA.mvc{i},100));
    rEMG{i}=winRMS(SynDataA.EMG{i},100);
    for m=1:7
       %SynDataA.ratioA{i}(:,m)=SynDataA.EMG{i}(:,m)./mmvcA{i}(m)*100;
       SynDataA.ratioa{i}(:,m)=rEMG{i}(:,m)./rmvc{i}(m)*100;
       %SynDataA.ratioa{i}(:,m)=SynDataA.EMG{i}(:,m)./amvcA{i}(m)*100;
        
    end
    if 0
        figure(1)
        subplot(5,5,i)
        plot(SynDataA.ratioa{i}(:,2:3))
        title(['FM=' num2str(SynDataA.FM(i))]);
        %ylim([0 30])
        legend('2','3')
        %legend('2','3','4','5')
    %    legend('1','2','3','4','5','6','7')
    %     plot(Cmvc{i}(:,2))
    %     hold on 
    %     plot(indataA.EMGA{i}(:,2),'r')
    %     figure(2)
    %     subplot(4,4,i)
    %     plot(indataA.EMGA{i}(:,2:3))
    end
end

 SynDataA.ratioa=SynDataA.ratioa';
% SynDataA.ratioU=SynDataA.ratioU';
for i=1:length(SynDataU.EMG)
%     SynDataU.EMG{i}=EMGPre(SynDataU.EMG{i});
%     SynDataU.mvc{i}=EMGPre(SynDataU.mvc{i});
    %pmvc{i}=max(winMean(SynDataA.mvc{i},100));
    
    
    rmvcU{i}=max(winRMS(SynDataU.mvc{i},20));
    rEMGU{i}=winRMS(SynDataU.EMG{i},20);
    for m=1:7
        SynDataU.ratioa{i}(:,m)=rEMGU{i}(:,m)./rmvcU{i}(m)*100;
        %SynDataU.ratio{i}(:,m)=SynDataU.EMG{i}(:,m)./mmvcu{i}(m)*100;
    end
    if 1
        figure(2)
        subplot(5,5,i)
        plot(SynDataU.ratioa{i}(:,2:3))
        %ylim([0 30])
        legend('2','3')
        %legend('2','3','4','5')
    end
end
% SynDataU.ratio=SynDataU.ratio';