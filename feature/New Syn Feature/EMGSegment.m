close all;clear ;clc
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
load('../../DATA/locA');
load('../../DATA/locH');
addpath('../../SignalProcess')
addpath('../../feature')

disiEMGA=0;
cla='b';


for i=1:length(SynDataA.EMG)
    SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
    EMGA{i}=winRMS(SynDataA.EMG{i},20);
    meanA(i,:)=mean(EMGA{i});
    EMGA1{i}=EMGA{i}(1:locA(i)-1,:);                %flx
    EMGA2{i}=EMGA{i}(locA(i):min(length(EMGA{i}),length(SynDataA.shdAng{i})),:);    %hold
    meanA1(i,:)=mean(EMGA1{i});
    meanA2(i,:)=mean(EMGA2{i});
end
for i=1:length(SynDataU.name)
    SynDataU.EMGR{i}=EMGPre(SynDataU.EMGR{i});
    EMGU{i}=winRMS(SynDataU.EMGR{i},20);
    meanU(i,:)=mean(EMGU{i});
    EMGU1{i}=EMGU{i}(1:locH(i)-1,:);
    EMGU2{i}=EMGU{i}(locH(i):min(length(EMGU{i}),length(SynDataU.shdAngR{i})),:);
    meanU1(i,:)=mean(EMGU1{i});
    meanU2(i,:)=mean(EMGU2{i});
end
% [Mdata,Sdata,p]=ErrorbarPlot2(meanA1,SynDataA.group);
[Grp1,Grp2,Grp3,Grp4]=group4(SynDataA.group);
[Mdata,Sdata,p]=ErrorbarPlot5(meanA1(Grp1,:),'group1',meanA1(Grp2,:),'group2',meanA1(Grp3,:),'group3',meanA1(Grp4,:),'group4',meanU1,'Healthy people','Strength of Contraction',1);
p1=anova1(meanA1(:,3),SynDataA.group);

group2=[group group2];
Mdata1=[meanA ;meanU];


[Mdata,Sdata,p]=ErrorbarPlot2(Mdata1,group2);
[Mdata,Sdata,p]=ErrorbarPlot(meanA,'Affected Side',meanU,'Healthy People','Strength of Contraction',1);