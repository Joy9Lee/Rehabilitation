close all;clear ;clc
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
load('../../DATA/locA');
load('../../DATA/locH');
addpath('../../SignalProcess')
addpath('../../feature')
for i=1:length(SynDataA.EMG)
    SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
    EMGA{i}=winRMS(SynDataA.EMG{i},20);
    EMGA1{i}=EMGA{i}(1:locA(i)-1,:);                %flx
    EMGA2{i}=EMGA{i}(locA(i):min(length(EMGA{i}),length(SynDataA.shdAng{i})),:);    %hold
    meanA1(i,:)=mean(EMGA1{i});
    meanA2(i,:)=mean(EMGA2{i});
    ratioA{i}=EMGA{i}(:,5)./EMGA{i}(:,6);
    ratioA1{i}=EMGA1{i}(:,5)./EMGA1{i}(:,6);        %flx
    ratioA2{i}=EMGA2{i}(:,5)./EMGA2{i}(:,6);        %hold
    [maxRatio(i) indexA(i)]=max(ratioA1{i});

    
     
end
locA=locA';
for i=1:length(SynDataU.EMGR)
    SynDataU.EMGR{i}=EMGPre(SynDataU.EMGR{i});
    EMGU{i}=winRMS(SynDataU.EMGR{i},20);
    EMGU1{i}=EMGU{i}(1:locH(i)-1,:);
    EMGU2{i}=EMGU{i}(locH(i):min(length(EMGU{i}),length(SynDataU.shdAngR{i})),:);
    ratioU{i}=EMGU{i}(:,5)./EMGU{i}(:,6);
    ratioU1{i}=EMGU1{i}(:,5)./EMGU1{i}(:,6);
    ratioU2{i}=EMGU2{i}(:,5)./EMGU2{i}(:,6);
    [maxRatioU(i) indexU(i)]=max(ratioU1{i});
end

locH=locH';
group2=5*ones(length(SynDataU.EMGR),1);
group2=[SynDataA.group;group2];
AllData=[maxRatio maxRatioU];
p=anova1(AllData,group2);
ylabel('Max Power Ratio')
xlabel('Group')
al=[indexA indexU]./50;
p2=anova1(al,group2);
ylabel('Time/s')
xlabel('Group')
