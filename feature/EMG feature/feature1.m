%% In this m file calculates the error bar of mean raise ratio and corr between similarity and FM. 
close all
clear all
clc
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');
addpath('../../SignalProcess')
fs=50;

%% sort the data according to the FM value
[temp,index] = sort(SynDataA.FM);
SynData1A.name=SynDataA.name(index);
SynData1A.FM=SynDataA.FM(index);
SynData1A.quat=SynDataA.quat(index);
%SynData1A.quatU=SynDataA.quatU(index);
SynData1A.EMG=SynDataA.EMG(index);
%SynData1A.EMGU=SynDataA.EMGU(index);
%SynData1A.ratioA=SynDataA.ratioA(index);
%SynData1A.ratioU=SynDataA.ratioU(index);

indataA=SynData1A;
indataU=SynDataU;
for i=1:length(indataA.EMG)
    if 0
    figure(1)
    subplot(4,4,i)
    plot(indataA.ratioA{i}(:,2:3))
    title(['FM=' num2str(indataA.FM(i))]);
    ylim([0 40])
    legend('2','3')
    end
end
for i=1:length(indataU.EMG)
    if 0
    figure(2)
    subplot(4,4,i)
    plot(indataU.ratio{i}(:,2:3))
    ylim([0 40])
    legend('2','3')
    end
    %legend('2','3','4','5')
end
%% find loc
[SynDataA.loc0, SynDataA.loc]=subsection('../../DATA/SynDataA',SynDataA);
SynDataA.loc0=SynDataA.loc0';
SynDataA.loc=SynDataA.loc';
[SynDataU.loc0, SynDataU.loc]=subsection('../../DATA/SynDataU',SynDataU);
SynDataU.loc0=SynDataU.loc0';
SynDataU.loc=SynDataU.loc';

%% save the holding part
for i=1:length(indataA.EMG)
   % SynDataA.rT{i}=SynDataA.ratio{i}(SynDataA.loc(i):end,:);
    rEMG{i}=CiEMG(SynDataA.EMG{i},20);
   SynDataA.rT{i}=rEMG{i}(SynDataA.loc(i)+1:end,:);
end
SynDataA.rT=SynDataA.rT';
for i=1:length(indataU.EMG)
    %SynDataU.rT{i}=SynDataU.ratio{i}(SynDataU.loc(i):end,:);
    rEMGU{i}=CiEMG(SynDataU.EMG{i},20);
    SynDataU.rT{i}=rEMGU{i}(SynDataU.loc(i)+1:end,:);
end
SynDataU.rT=SynDataU.rT';
SynData1A.rT=SynDataA.rT(index);
%% plot function

    for i=1:length(indataA.EMG)
        if 0
        figure(1)
        subplot(5,5,i)
        plot(SynDataA.ratioA{i}(:,2:3))
        title(['FM=' num2str(indataA.FM(i))]);
        ylim([0 40])
        legend('2','3')
        if 0
            figure(2)
            subplot(5,5,i)
            plot(SynDataA.rT{i}(:,2:3))
            title(['FM=' num2str(indataA.FM(i))]);
            %ylim([0 40])
            legend('2','3')

        end
        end
    end
    for i=1:length(indataU.EMG)
if 0
        figure(3)
        subplot(5,5,i)
        plot(indataU.ratio{i}(:,2:3))
        ylim([0 40])
        legend('2','3')

        %legend('2','3','4','5')
end
    end

  
 %% average ratio errorbar
 mRatioA=[];
 mRatioU=[];
 for i=1:length(indataA.EMG)
     %mRatioA{i}=mean(SynDataA.rT{i}); 
     mRatioA=[mRatioA;mean(SynDataA.rT{i})]; 
    
 end
 for i=1:length(indataU.EMG)
     mRatioU=[mRatioU;mean(SynDataU.rT{i})]; 
 end

    [Mdata,Sdata,s,p]=ErrorbarPlot(mRatioA,'Affected',mRatioU,'Unaffected',1);
%% corr
[r,p1]=mycorr(SynDataA.FM',s,1);
  
    
    
    