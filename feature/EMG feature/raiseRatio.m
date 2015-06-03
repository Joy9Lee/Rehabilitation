%% 三角肌前组募集率
close all
clear all
clc
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');
addpath('../../signalProcess')
fs=50;
for i=1:length(SynDataA.EMG)
%     SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
%     SynDataA.mvc{i}=EMGPre(SynDataA.mvc{i});
%     pmvc{i}=max(winMean(SynDataA.mvc{i},100));
%     rmvc{i}=mean(SynDataA.EMG{i});
%     rEMG{i}=CiEMG(SynDataA.EMG{i},20);
    
    rmvc{i}=max(winRMS(SynDataA.mvc{i},20));
    rEMG{i}=winRMS(SynDataA.EMG{i},20);
    
   %SynDataA.ratioA{i}(:,m)=SynDataA.EMG{i}(:,m)./mmvcA{i}(m)*100;
    SynDataA.ratio{i}=rEMG{i}(:,3)./rmvc{i}(3)*100;
   %SynDataA.ratioa{i}(:,m)=SynDataA.EMG{i}(:,m)./amvcA{i}(m)*100;
        
   
    if 1
        figure(1)
        subplot(5,5,i)
        plot(SynDataA.ratio{i})
        title(['FM=' num2str(SynDataA.FM(i))]);
        %ylim([0 30])
        %legend('2','3')
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
figure(1)
suptitle('患者归一化信号')
 SynDataA.ratio=SynDataA.ratio';
% SynDataA.ratioU=SynDataA.ratioU';
for i=1:length(SynDataU.EMG)
%     SynDataU.EMG{i}=EMGPre(SynDataU.EMG{i});
%     SynDataU.mvc{i}=EMGPre(SynDataU.mvc{i});
    %pmvc{i}=max(winMean(SynDataA.mvc{i},100));
    
    
    rmvcU{i}=max(winRMS(SynDataU.mvc{i},20));
    rEMGU{i}=winRMS(SynDataU.EMG{i},20);
    %rEMGU{i}=SynDataU.EMG{i},20;
    SynDataU.ratio{i}=rEMGU{i}(:,3)./rmvcU{i}(3)*100;
    %SynDataU.ratio{i}(:,m)=SynDataU.EMG{i}(:,m)./mmvcu{i}(m)*100;
    
    if 1
        figure(2)
        subplot(5,5,i)
        plot(SynDataU.ratio{i})
        %ylim([0 30])
        %legend('2','3')
        %legend('2','3','4','5')
    end
    

end
figure(2)
    suptitle('健康人归一化信号')
 SynDataU.ratio=SynDataU.ratio';