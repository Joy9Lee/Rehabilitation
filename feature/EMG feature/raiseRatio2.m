close all
clear all
clc
load('../../DATA/SynDataA2');
load('../../DATA/SynDataU');
addpath('../../signalProcess')
fs=50;
indataA=SynDataA;
indataU=SynDataU;
for i=1:length(indataA.EMG)
    
    CmvcA{i}=CiEMG(indataA.EMG{i},20);
    mmvcA{i}=mean(abs(CmvcA{i}));
    CmvcU{i}=CiEMG(indataA.EMGU{i},20);
    mmvcU{i}=mean(abs(CmvcU{i}));
    for m=1:7
        SynDataA.ratioA{i}(:,m)=indataA.EMG{i}(:,m)./mmvcA{i}(m)*100;
        SynDataA.ratioU{i}(:,m)=indataA.EMGU{i}(:,m)./mmvcU{i}(m)*100;
    end
    figure(1)
    subplot(5,4,i)
    plot(SynDataA.ratioA{i}(:,2:3))
    title(['FM=' num2str(indataA.FM(i))]);
    ylim([0 40])
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
% SynDataA.ratioA=SynDataA.ratioA';
% SynDataA.ratioU=SynDataA.ratioU';
for i=1:length(indataU.EMG)
    
    Cmvcu{i}=CiEMG(indataU.EMG{i},20);
    mmvcu{i}=mean(abs(Cmvcu{i}));
    for m=1:7
        SynDataU.ratio{i}(:,m)=indataU.EMG{i}(:,m)./mmvcu{i}(m)*100;
    end
    figure(2)
    subplot(4,4,i)
    plot(SynDataU.ratio{i}(:,2:3))
    ylim([0 40])
    legend('2','3')
    %legend('2','3','4','5')
end
% SynDataU.ratio=SynDataU.ratio';