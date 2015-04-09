%% EMGpower.m calculates some statistical features of affected and unaffected people
clc
close all
clear all
load('../DATA/synDataA');
load('../DATA/synDataU');
%addpath('../../signalProcess')
%% Affectd power ratio
j=1;
indataA=synDataA;
indataU=synDataU;
for i=1:length(indataA.sEMGA)
    if ~isempty(indataA.sEMGA{i})
        dataA.EMG{j}=CiEMG(indataA.sEMGA{i},20);
        dataA.FM(j)=indataA.FM(i);
        dataA.quat(j)=indataA.quatA(i);
%         dataA.loc1(j)=indataA.loc1(i);
%         dataA.EMGT{j}=dataA.EMG{j}(dataA.loc1(j)+1:end,:);
        j=j+1;
    end
end

%pRatioA=PowerRatio(dataA.EMGT);
pRatioA=PowerRatio(dataA.EMG);

%% Unaffected power ratio
j=1;
for i=1:length(indataU.sEMG)
    if ~isempty(indataU.sEMG{i})
        dataU.EMG{j}=CiEMG(indataU.sEMG{i},20);
         dataU.quat(j)=indataU.quat(i);
%         dataU.loc1(j)=indataU.loc1(i);
        %dataU.EMGT{j}=dataU.EMG{j}(dataU.loc1(j)+1:end,:);
        j=j+1;
    end
   
end

pRatioU=PowerRatio(dataU.EMG);
% for j=1:7                   %get rid of the zero lines of an array
%     id=pRatioU(:,j)==0;              
%     pRatioU(id,:)=[];
% end

[Mdata,Sdata,s,p]=ErrorbarPlot(pRatioA,'Affected',pRatioU,'Unaffected',1);
r=pRatioA(:,3)./pRatioA(:,2);           %ratio of muscle3 to muscle2
mycorr(dataA.FM,r',1)
figure
bar(r)
MdataU=mean(pRatioU);
for k=1:length(pRatioA)
    sU(k)=similarity(pRatioA(k,:),MdataU);
end
% figure
% bar(pRatioU',0.5 )
% figure
% bar(pRatioA',0.5)