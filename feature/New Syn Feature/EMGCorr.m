close all;clear ;clc
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
addpath('../../SignalProcess')
addpath('../../feature')
for i=1:length(SynDataA.EMG)
    iEMGA{i}=winRMS(SynDataA.EMG{i},20);
    %iEMGA{i}=winRMS(EMGA{i},10);
    r(i)=mean(iEMGA{i}(:,3)./iEMGA{i}(:,2));
    meanA(i,:)=mean(iEMGA{i});
    FM(i)=SynDataA.FM(i);
end
FM=FM';
r=r';
for i=1:7
    [r1(i),p(i)]=corrAnaly(FM,'FM',meanA(:,i),'三角肌前组',0);
end
  [r2(i),p2(i)]=corrAnaly(FM,'FM',r,'三角肌前组',1);