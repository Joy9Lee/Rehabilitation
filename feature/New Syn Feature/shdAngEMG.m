%% This m file try to find the difference between angle and power ratio in different segments.
close all;clear ;clc
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
load('../../DATA/locA');
load('../../DATA/locH');
addpath('../../SignalProcess')
addpath('../../feature')
%% choose label
LABEL='h';

for i=1:length(SynDataA.EMG)
    SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
    EMGA{i}=winRMS(SynDataA.EMG{i},20);
    %EMGA{i}=CiEMG(SynDataA.EMG{i},20);
    %     EMGA1{i}=EMGA{i}(1:locA(i)-1,:);
    %     EMGA2{i}=EMGA{i}(locA(i):min(length(EMGA{i}),length(SynDataA.shdAng{i})),:);
    EMGA1{i}=EMGA{i}(1:locA(i)-1,:);
    EMGA2{i}=EMGA{i}(locA(i):min(length(EMGA{i}),length(SynDataA.shdAng{i})),:);
    meanA1(i,:)=mean(EMGA1{i});
    meanA2(i,:)=mean(EMGA2{i});
    ratioA1{i}=EMGA1{i}(:,3)./EMGA1{i}(:,2);
    ratioA2{i}=EMGA2{i}(:,3)./EMGA2{i}(:,2);
    meanA3(i)=mean(ratioA1{i});
    meanA4(i)=mean(ratioA2{i});
end
for i=1:length(SynDataU.EMGR)
    SynDataU.EMGR{i}=EMGPre(SynDataU.EMGR{i});
    EMGU{i}=winRMS(SynDataU.EMGR{i},20);
    % EMGU{i}=CiEMG(SynDataU.EMGR{i},20);
    EMGU1{i}=EMGU{i}(1:locH(i)-1,:);
    EMGU2{i}=EMGU{i}(locH(i):min(length(EMGU{i}),length(SynDataU.shdAngR{i})),:);
    meanU1(i,:)=mean(EMGU1{i});
    meanU2(i,:)=mean(EMGU2{i});
    ratioU1{i}=EMGU1{i}(:,3)./EMGU1{i}(:,2);
    ratioU2{i}=EMGU2{i}(:,3)./EMGU2{i}(:,2);
    meanU3(i)=mean(ratioU1{i});
    meanU4(i)=mean(ratioU2{i});
end
[p1,p2,Mdata1,Sdata1]=grorpBarPlot(SynDataA.group,LABEL,meanA1,meanA2,meanU1,meanU2,'Strength of Contraction');
[p3,p4,Mdata2,Sdata2]=grorpBarPlot(SynDataA.group,LABEL,meanA3',meanA4',meanU3',meanU4','Ratio');     %ratio
