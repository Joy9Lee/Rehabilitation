close all;clear ;clc
load('../../DATA/SynDataA_35');
load('../../DATA/SynDataU_23');
for i=1:length(SynDataU.name)
    SynDataU.EMGR{i}=EMGPre(SynDataU.EMGR{i});
    SynDataU.EMGL{i}=EMGPre(SynDataU.EMGL{i});
    iEMGR{i}=winRMS(SynDataU.EMGR{i},20);
    iEMGL{i}=winRMS(SynDataU.EMGL{i},20);
    meanR(i,:)=mean(iEMGR{i});
    meanL(i,:)=mean(iEMGL{i});
    
end
for i=1:length(SynDataA.EMG)
    SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
    iEMGA{i}=winRMS(SynDataA.EMG{i},20);
    meanA(i,:)=mean(iEMGA{i});
    SynDataA.EMGU{i}=EMGPre(SynDataA.EMGU{i});
    iEMGU{i}=winRMS(SynDataA.EMGU{i},20);
    meanU(i,:)=mean(iEMGU{i});
end
Mdata1=[meanA ;meanU];
[Mdata,Sdata,p]=ErrorbarPlot(meanA,'Affected Side',meanU,'Healthy Side','Strength of Contraction',1);
%[Mdata,Sdata,p]=ErrorbarPlot(meanR,'Healthy People Right Side',meanL,'Healthy People Left Side','Strength of Contraction',1);