close all;clear ;clc
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
addpath('../../SignalProcess')
addpath('../../feature')
load('../../DATA/locA');
load('../../DATA/locH');
load('../../DATA/locAU');
load('../../DATA/locHL');
for i=1:length(SynDataU.name)
    SynDataU.EMGR{i}=EMGPre(SynDataU.EMGR{i});
    EMGU{i}=CiEMG(SynDataU.EMGR{i},20);
    %EMGU{i}=winRMS(SynDataU.EMGR{i},20);
    EMGU1{i}=EMGU{i}(1:locH(i)-1,:);
    EMGU2{i}=EMGU{i}(locH(i):min(length(EMGU{i}),length(SynDataU.shdAngR{i})),:);
    meanU1(i,:)=mean(EMGU1{i});
    meanU2(i,:)=mean(EMGU2{i});
    ratioU1{i}=EMGU1{i}(:,3)./EMGU1{i}(:,2);
    ratioU2{i}=EMGU2{i}(:,3)./EMGU2{i}(:,2);
    meanUr1(i)=mean(ratioU1{i});
    meanUr2(i)=mean(ratioU2{i});
    ratioU3{i}=EMGU1{i}(:,5)./EMGU1{i}(:,6);
    ratioU4{i}=EMGU2{i}(:,5)./EMGU2{i}(:,6);
    meanU3(i)=mean(ratioU3{i});
    meanU4(i)=mean(ratioU4{i});
    if ~isempty(SynDataU.EMGL{i})
    SynDataU.EMGL{i}=EMGPre(SynDataU.EMGL{i});
    EMGUL{i}=CiEMG(SynDataU.EMGL{i},20);
    EMGU1L{i}=EMGUL{i}(1:locHL(i)-1,:);
    EMGU2L{i}=EMGUL{i}(locHL(i):min(length(EMGUL{i}),length(SynDataU.shdAngL{i})),:);
    meanU1L(i,:)=mean(EMGU1L{i});
    meanU2L(i,:)=mean(EMGU2L{i});
    ratioU1L{i}=EMGU1L{i}(:,3)./EMGU1L{i}(:,2);
    ratioU2L{i}=EMGU2L{i}(:,3)./EMGU2L{i}(:,2);
    meanU1rL(i)=mean(ratioU1L{i});
    meanU2rL(i)=mean(ratioU2L{i});
    ratioU3L{i}=EMGU1L{i}(:,5)./EMGU1L{i}(:,6);
    ratioU4L{i}=EMGU2L{i}(:,5)./EMGU2L{i}(:,6);
    meanU3L(i)=mean(ratioU3L{i});
    meanU4L(i)=mean(ratioU4L{i});
    end
    
    
    
end
meanUr1=meanUr1';
meanUr2=meanUr2';
meanU3=meanU3';
meanU4=meanU4';
meanU3L=meanU3L';
meanU4L=meanU4L';
meanU1rL=meanU1rL';
meanU2rL=meanU2rL';