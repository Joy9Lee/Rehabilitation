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
for i=1:length(SynDataU.name)
    SynDataU.EMGR{i}=EMGPre(SynDataU.EMGR{i});
    EMGU{i}=winRMS(SynDataU.EMGR{i},20);
    meanU(i,:)=mean(EMGU{i});
    EMGU1{i}=EMGU{i}(1:locH(i)-1,:);
    EMGU2{i}=EMGU{i}(locH(i):min(length(EMGU{i}),length(SynDataU.shdAngR{i})),:);
    meanU1(i,:)=mean(EMGU1{i});
    meanU2(i,:)=mean(EMGU2{i});
    if ~isempty(SynDataU.EMGL{i})
   SynDataU.EMGL{i}=EMGPre(SynDataU.EMGL{i});
    EMGUL{i}=winRMS(SynDataU.EMGL{i},20);
    meanUL(i,:)=mean(EMGUL{i});
    EMGU1L{i}=EMGUL{i}(1:locHL(i)-1,:);
    EMGU2L{i}=EMGUL{i}(locHL(i):min(length(EMGUL{i}),length(SynDataU.shdAngL{i})),:);
    meanU1L(i,:)=mean(EMGU1L{i});
    meanU2L(i,:)=mean(EMGU2L{i});
    end
    
    
    
end