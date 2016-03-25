close all; clear all; clc;
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');
addpath('../../SignalProcess');
for i=1:length(SynDataA.EMG)
    %mEMG(i,:)=max(abs(SynDataA.EMG{i}));
    mEMG(i,:)=max(SynDataA.EMG{i});
   
end
for i=1:length(SynDataU.EMG)
    mEMGC(i,:)=max(SynDataU.EMG{i});
    %mEMGC(i,:)=max(abs(SynDataU.EMG{i}));
end
[Mdata1,Sdata1,p1]=ErrorbarPlot(mEMG,'Affected',mEMGC,'Control','maxEMG',1);
