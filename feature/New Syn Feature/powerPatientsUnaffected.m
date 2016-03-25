close all;clear ;clc
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
addpath('../../SignalProcess')
addpath('../../feature')
load('../../DATA/locA');
load('../../DATA/locH');
load('../../DATA/locAU');
load('../../DATA/locHL');
for i=1:length(SynDataA.EMGU)
    if ~isempty(SynDataA.EMGU{i})
        SynDataA.EMGU{i}=EMGPre(SynDataA.EMGU{i});
        EMGA{i}=CiEMG(SynDataA.EMGU{i},20);
        EMGA1{i}=EMGA{i}(1:locAU(i)-1,:);
        EMGA2{i}=EMGA{i}(locAU(i):min(length(EMGA{i}),length(SynDataA.shdAngU{i})),:);
        meanA1(i,:)=mean(EMGA1{i});
        meanA2(i,:)=mean(EMGA2{i});
        ratioA1{i}=EMGA1{i}(:,3)./EMGA1{i}(:,2);
        ratioA2{i}=EMGA2{i}(:,3)./EMGA2{i}(:,2);
        meanA3(i)=mean(ratioA1{i});
        meanA4(i)=mean(ratioA2{i});
        ratioA3{i}=EMGA1{i}(:,5)./EMGA1{i}(:,6);
        ratioA4{i}=EMGA2{i}(:,5)./EMGA2{i}(:,6);
        meanA5(i)=mean(ratioA3{i});
        meanA6(i)=mean(ratioA4{i});
    end
    
end
meanA3=meanA3';
meanA4=meanA4';
meanA5=meanA5';
meanA6=meanA6';

