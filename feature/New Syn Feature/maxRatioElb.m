close all;clear ;clc
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
load('../../DATA/locA');
load('../../DATA/locH');
addpath('../../SignalProcess')
addpath('../../feature')
for i=1:length(SynDataA.EMG)
    SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
    EMGA{i}=winRMS(SynDataA.EMG{i},20);
    EMGA1{i}=EMGA{i}(1:locA(i)-1,:);                %flx
    EMGA2{i}=EMGA{i}(locA(i):min(length(EMGA{i}),length(SynDataA.shdAng{i})),:);    %hold
    meanA1(i,:)=mean(EMGA1{i});
    meanA2(i,:)=mean(EMGA2{i});
    ratioA{i}=EMGA{i}(:,5)./EMGA{i}(:,6);
    ratioA1{i}=EMGA1{i}(:,5)./EMGA1{i}(:,6);        %flx
    ratioA2{i}=EMGA2{i}(:,5)./EMGA2{i}(:,6);        %hold
    meanA3(i)=mean(ratioA1{i});
    stdA3(i)=std(ratioA1{i});
    meanA4(i)=mean(ratioA2{i});
    dA{i}=diff(ratioA1{i});
%     for j=1:locA(i)                                  %calculate the elbow angle when the ratio has the maximum value
%         meanRatio{i}(j)=mean(ratioA{i}(j:j+3));
%         
%     end
meanRatio{i}=max(ratioA1{i})
    [maxRatio(i) indexA(i)]=max(meanRatio{i});
    elbA(i)=SynDataA.elbAng{i}(indexA(i));
    indexA=indexA';
    figure(1)
    subplot(5,8,i)
    plot(dA{i},'r')
      if 0
    figure
%     subplot(5,8,i)
    plot(SynDataA.elbAng{i},'r')
    hold on
    plot(ratioA{i},'b')
    hold on
     plot([locA(i) locA(i)],[min(SynDataA.shdAng{i}),max(SynDataA.elbAng{i})],'--m');
 %    ylim([0 50])
    title(['Grp=' num2str(SynDataA.group(i))]);
     end
end
locA=locA';
EA=mean(elbA);
elbA=elbA';
for i=1:length(SynDataU.EMGR)
    SynDataU.EMGR{i}=EMGPre(SynDataU.EMGR{i});
    EMGU{i}=winRMS(SynDataU.EMGR{i},20);
    EMGU1{i}=EMGU{i}(1:locH(i)-1,:);
    EMGU2{i}=EMGU{i}(locH(i):min(length(EMGU{i}),length(SynDataU.shdAngR{i})),:);
    meanU1(i,:)=mean(EMGU1{i});
    meanU2(i,:)=mean(EMGU2{i});
    ratioU{i}=EMGU{i}(:,5)./EMGU{i}(:,6);
    ratioU1{i}=EMGU1{i}(:,5)./EMGU1{i}(:,6);
    ratioU2{i}=EMGU2{i}(:,5)./EMGU2{i}(:,6);
    meanU3(i)=mean(ratioU1{i});
    meanU4(i)=mean(ratioU2{i});
    stdU3(i)=std(ratioU1{i});
    dU{i}=diff(ratioU1{i});
     figure(2)
    subplot(5,8,i)
    plot(dU{i},'r')
%     for j=1:locH(i)                                  %calculate the elbow angle when the ratio has the maximum value
%         meanRatioU{i}(j)=mean(ratioU{i}(j:j+3));
%         
%     end
meanRatioU{i}=max(ratioU1{i})
    [maxRatioU(i) indexU(i)]=max(meanRatioU{i});
    elbU(i)=SynDataU.elbAngR{i}(indexU(i));
   
     if 0
    figure
%    subplot(5,8,i)
    plot(SynDataU.elbAngR{i},'r')
    hold on
    plot(ratioU{i},'b')
    ylim([0 50])
    hold on
    plot([locH(i) locH(i)],[min(SynDataU.elbAngR{i}),max(SynDataU.elbAngR{i})],'--m');
    end
end
[Grp1,Grp2,Grp3,Grp4]=group4(SynDataA.group);
indexU=indexU';
locH=locH';
elbU=elbU';
EU=mean(elbU);
[h2,p8]=ttest2(elbA,elbU);
[h2,p7]=ttest2(stdA3(Grp2),stdA3(Grp3));
%[Mdata,Sdata,p1]=diffAnaly(elbA,'elbA',elbU,'elbU','elbAng',1);
group2=5*ones(length(SynDataU.EMGR),1);
group2=[SynDataA.group;group2];
AllData=[elbA;elbU];
p=anova1(AllData,group2);
p=anova1(elbA);