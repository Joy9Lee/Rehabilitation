close all; clear all; clc;
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');
addpath('../../SignalProcess');
id=[];
idg=[];
for i=1:length(SynDataA.EMG)
    [acTime{i},acSeq{i},X{i}]=ActSeq(SynDataA.EMG{i});
%    [mEMG{i} maxTime{i}]=max(abs(SynDataA.EMG{i}));
%     time(i,:)=(maxTime{i}-X{i})/1000;
     [mEMG{i} maxTime{i}]=max(CiEMG(SynDataA.EMG{i},20)/20);
    time(i,:)=((maxTime{i}-1)*20-X{i})/1000;
    
% %     if any(isinf(time(i,:)))
% %         id=[id i];
% %     end
 % gradientA(i,:)=mEMG{i}./((maxTime{i}-1)*20)/20;
 if ~any(isinf(X{i}))
     s{i}=sum(abs(SynDataA.EMG{i}(1:20,:)))/20*3;
 %     gradientA(i,:)=(mEMG{i}-s{i})./((maxTime{i}-1)*20+10-X{i});
      gradientA(i,:)=mEMG{i}./((maxTime{i}-1)*20-X{i});
%       for j=1:7
%           
%          gradientA(i,j)=mEMG{i}(j)-SynDataA.EMG{i}(X{i}(j),j);
%       end
     %gradientA(i,:)=gradientA(i,:)./(maxTime{i}-X{i});
%      gradientA(i,:)=gradientA(i,:)./((maxTime{i}-1)*20-X{i});
 end
  
end
% % time(id,:)=[];
%gradientA(idg,:)=[];
% gradientA(3,:)=[];
 
acSeq=acSeq';
for i=1:length(SynDataU.EMG)
    [acTimeC{i},acSeqC{i},XC{i}]=ActSeq(SynDataU.EMG{i});
 %   [mEMGC{i} maxTimeC{i}]=max(abs(SynDataU.EMG{i}));
%     timeC(i,:)=(maxTimeC{i}-XC{i})/1000;
    [mEMGC{i} maxTimeC{i}]=max(CiEMG(SynDataU.EMG{i},20)/20);
    timeC(i,:)=((maxTimeC{i}-1)*20-XC{i})/1000;
    sC{i}=sum(abs(SynDataU.EMG{i}(1:20,:)))/20*3;
    gradientC(i,:)=(mEMGC{i})./((maxTimeC{i}-1)*20-XC{i});  
%     gradientC(i,:)=(mEMGC{i}-sC{i})./((maxTimeC{i}-1)*20+10-XC{i});   
%     for j=1:7
%          gradientC(i,j)=(mEMGC{i}(j)-SynDataA.EMG{i}(XC{i}(j),j));
%     end
%      gradientC(i,:)=gradientC(i,:)./(maxTimeC{i}-XC{i});
%    gradientC(i,:)=mEMGC{i}./((maxTimeC{i}-1)*20)/20;

 end

acSeqC=acSeqC';
[Mdata1,Sdata1,p1]=ErrorbarPlot(time,'Affected',timeC,'Control','ActiveTime/s',1);
[Mdata2,Sdata2,p2]=ErrorbarPlot(gradientA,'Affected',gradientC,'Control','gradient',0);
