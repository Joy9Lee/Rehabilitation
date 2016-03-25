close all;clear ;clc
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
addpath('../../SignalProcess')
addpath('../../feature')

disiEMGA=0;
for i=1:length(SynDataA.EMG)
    %     iEMGA{i}=CiEMG(SynDataA.EMG{i},20);
    SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
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
    SynDataU.EMGR{i}=EMGPre(SynDataU.EMGR{i});
    EMGU{i}=winRMS(SynDataU.EMGR{i},20);
    iEMGU{i}=winRMS(EMGU{i},10);
    meanU(i,:)=mean(iEMGU{i});
    %    iEMGU{i}=winRMS(SynDataU.EMGR{i},20);
end

Grp1=[]; Grp2=[]; Grp3=[]; Grp4=[];
for i =1 : length(SynDataA.FM)
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
[Mdata,Sdata,p]=ErrorbarPlot(meanA,'affect',meanU,'health','iEMG of 7 muscles',1)