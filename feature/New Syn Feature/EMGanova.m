close all;clear ;clc
% load('../../DATA/SynDataA_39');
% load('../../DATA/SynDataU_25');
load('../../DATA/SynDataA16_M3');
load('../../DATA/SynDataU19_M3');

addpath('../../SignalProcess')
addpath('../../feature')

disiEMGA=1;
for i=1:length(SynDataA.EMG)
%     iEMGA{i}=CiEMG(SynDataA.EMG{i},20);
EMGA{i}=winRMS(SynDataA.EMG{i},20);
iEMGA{i}=winRMS(EMGA{i},10);
    meanA(i,:)=mean(iEMGA{i});
    if disiEMGA==1
        figure
        plot(iEMGA{i})
        if i==1
            legend('胸大肌','斜方肌','三角肌前组','三角肌中组','肱二头肌','肱三头肌','肱桡机');
        end
    end
end

for i=1:length(SynDataU.name)
%    iEMGU{i}=CiEMG(SynDataU.EMGR{i},20);
    EMGU{i}=winRMS(SynDataU.EMGR{i},20);
    iEMGU{i}=winRMS(EMGU{i},10);
    meanU(i,:)=mean(iEMGU{i});
%    iEMGU{i}=winRMS(SynDataU.EMGR{i},20);
end
group=[]; group2=[];
Grp1=[]; Grp2=[]; Grp3=[]; Grp4=[];
for i =1 : length(SynDataA.FM)
    group=[group SynDataA.group(i)];
    switch SynDataA.group(i)
        case 1
            Grp1=[Grp1 i];
        case 2
            Grp2=[Grp2 i];
        case 3
            Grp3=[Grp3 i];
        case 4
            Grp4=[Grp4 i];
    end
end
for j=1: length(SynDataU.EMGR)
    group2=[group2 5];
end
group2=[group group2];
Mdata=[meanA ;meanU];
for i=1:7
     p(i)=anova1(Mdata(:,i),group2);
end
