close all;clear ;clc
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
addpath('../../SignalProcess')
addpath('../../feature')
load('../../DATA/locA');
load('../../DATA/locH');
load('../../DATA/locAU');
load('../../DATA/locHL');

disiEMGA=0;
for i=1:length(SynDataA.EMG)
    if ~isempty(SynDataA.EMGU{i})
    SynDataA.EMGU{i}=EMGPre(SynDataA.EMGU{i});
    EMGA{i}=winRMS(SynDataA.EMGU{i},20);
    
    EMGA1{i}=EMGA{i}(1:locAU(i)-1,:);
    EMGA2{i}=EMGA{i}(locAU(i):min(length(EMGA{i}),length(SynDataA.shdAngU{i})),:);
    meanA1(i,:)=mean(EMGA1{i});
    meanA2(i,:)=mean(EMGA2{i});
    
    end
end