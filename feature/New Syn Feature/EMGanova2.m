close all;clear ;clc
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
addpath('../../SignalProcess')
addpath('../../feature')

disiEMGA=0;
cla='b';


for i=1:length(SynDataA.EMG)
    %     iEMGA{i}=CiEMG(SynDataA.EMG{i},20);
    SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
    iEMGA{i}=winRMS(SynDataA.EMG{i},20);
    %iEMGA{i}=winRMS(EMGA{i},10);
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
   SynDataU.EMGR{i}=EMGPre(SynDataU.EMGR{i});
    %    iEMGU{i}=CiEMG(SynDataU.EMGR{i},20);
    iEMGU{i}=winRMS(SynDataU.EMGR{i},20);
    %iEMGU{i}=winRMS(EMGU{i},10);
    meanU(i,:)=mean(iEMGU{i});
    %    iEMGU{i}=winRMS(SynDataU.EMGR{i},20);
end
group=[]; group2=[];
Grp1=[]; Grp2=[]; Grp3=[]; Grp4=[];
for i =1 : length(SynDataA.FM)
  
    if cla=='b'
        %% classify by Brunnstrom
        switch SynDataA.group(i)
            case {1,2}
                group=[group 1];
            case {3,4}
                group=[group 2];
        end
       
    elseif cla=='h'
         %% classify by hypertonia
        switch SynDataA.group(i)
            case {1,3}
               group=[group 1];
            case {2,4}
               group=[group 2];
        end
    end
end
for j=1: length(SynDataU.EMGR)
    group2=[group2 3];
end
group2=[group group2];
Mdata1=[meanA ;meanU];
for i=1:7
    p(i)=anova1(meanA(:,i),SynDataA.group);
%     p(i)=anova1(Mdata(:,i),group2);
end
%[Mdata,Sdata,p]=ErrorbarPlot2(meanA,group)

[Mdata,Sdata,p]=ErrorbarPlot2(Mdata1,group2);
 [Mdata,Sdata,p]=ErrorbarPlot(meanA,'Affected Side',meanU,'Healthy People','Strength of Contraction',1);