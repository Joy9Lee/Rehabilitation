%% main.m calculates some statistical features of affected and unaffected people
clc
close all
clear all
load('../DATA/dataSetA');
load('../DATA/dataSetU');
%% Affectd power ratio
j=1;
for i=1:length(dataSetA.sEMG)
    if ~isempty(dataSetA.sEMG{i})
        dataA.EMG{j}=CiEMG(dataSetA.sEMG{i},20);
        dataA.FM(j)=dataSetA.FM(i);
        dataA.loc1(j)=dataSetA.loc1(i);
        dataA.EMGT{j}=dataA.EMG{j}(dataA.loc1(j)+1:end,:);
        j=j+1;
    end
end

%pRatioA=PowerRatio(dataA.EMGT);
pRatioA=PowerRatio(dataA.EMG);

%% Unaffected power ratio
j=1;
for i=1:length(dataSetU.sEMG)
    if ~isempty(dataSetU.sEMG{i})
        dataU.EMG{j}=CiEMG(dataSetU.sEMG{i},20);
        dataU.loc1(j)=dataSetU.loc1(i);
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