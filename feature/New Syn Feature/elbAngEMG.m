%% This m file try to find the difference between angle and power ratio in different segments.
close all;clear ;clc
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
load('../../DATA/locA');
load('../../DATA/locH');
addpath('../../SignalProcess')
addpath('../../feature')
LABEL='h';
for i=1:length(SynDataA.EMG)
   SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
    EMGA{i}=winRMS(SynDataA.EMG{i},20);
%      EMGA{i}=CiEMG(SynDataA.EMG{i},20);
    EMGA1{i}=EMGA{i}(1:locA(i)-1,:);                %flx
    EMGA2{i}=EMGA{i}(locA(i):min(length(EMGA{i}),length(SynDataA.shdAng{i})),:);    %hold
    meanA1(i,:)=mean(EMGA1{i});
    meanA2(i,:)=mean(EMGA2{i});
    ratioA{i}=EMGA{i}(:,5)./EMGA{i}(:,6);       
    ratioA1{i}=EMGA1{i}(:,5)./EMGA1{i}(:,6);        %flx
    ratioA2{i}=EMGA2{i}(:,5)./EMGA2{i}(:,6);        %hold
%  ratioA{i}=EMGA{i}(:,6)./EMGA{i}(:,5);       
%     ratioA1{i}=EMGA1{i}(:,6)./EMGA1{i}(:,5);        %flx
%     ratioA2{i}=EMGA2{i}(:,6)./EMGA2{i}(:,5);        %hold
    meanA(i)=mean(ratioA{i});
    meanA3(i)=mean(ratioA1{i});
    meanA4(i)=mean(ratioA2{i});
   if 1
    figure(i)
     %subplot(5,8,i)
    plot(SynDataA.elbAng{i},'r')
    hold on
%     plot(SynDataA.shdAng{i},'b')
%     hold on
    plot(ratioA{i},'b')
%    hold on
%      plot([locA(i) locA(i)],[min(SynDataA.shdAng{i}),max(SynDataA.elbAng{i})],'--m');
 %   plot([locA(i) locA(i)],[0,max(ratioA{i})],'--m');
    legend('Elbow Angle','Power Ratio')
   %  ylim([0 90])
   title(['Grp=' num2str(SynDataA.group(i))]);
 % title(['FM=' num2str(SynDataA.FM(i))]);
    if 0
     figure(2)
    subplot(5,8,i)
    plot(SynDataA.elbAng{i}(1:locA(i)-1),'r')
    hold on
    plot(ratioA{i}(1:locA(i)+1),'b')
    ylim([0 50])
     figure(3)
    subplot(5,8,i)
    plot(SynDataA.elbAng{i}(locA(i):min(length(EMGA{i}),length(SynDataA.shdAng{i}))),'r')
    hold on
    plot(ratioA{i}(locA(i):min(length(EMGA{i}),length(SynDataA.shdAng{i}))),'b')
    ylim([0 50])
    end
   end
end
%suptitle('Affected Side Elbow Angle')
locA=locA';

for i=1:length(SynDataU.EMGR)
    SynDataU.EMGR{i}=EMGPre(SynDataU.EMGR{i});
   EMGU{i}=winRMS(SynDataU.EMGR{i},20);
%      EMGU{i}=CiEMG(SynDataU.EMGR{i},20);
    EMGU1{i}=EMGU{i}(1:locH(i)-1,:);
    EMGU2{i}=EMGU{i}(locH(i):min(length(EMGU{i}),length(SynDataU.shdAngR{i})),:);
    meanU1(i,:)=mean(EMGU1{i});
    meanU2(i,:)=mean(EMGU2{i});
    ratioU{i}=EMGU{i}(:,5)./EMGU{i}(:,6);
    ratioU1{i}=EMGU1{i}(:,5)./EMGU1{i}(:,6);
    ratioU2{i}=EMGU2{i}(:,5)./EMGU2{i}(:,6);
    %meanU(i)=mean(ratioU{i});
    meanU3(i)=mean(ratioU1{i});
    meanU4(i)=mean(ratioU2{i});
    if 0
    figure(i)
 %   subplot(5,8,i)
 %    plot(SynDataU.shdAngR{i},'b')
     plot(SynDataU.elbAngR{i},'r')
     hold on
    plot(ratioU{i},'b')
%    ylim([0 90])
%    hold on
%      plot([locH(i) locH(i)],[min(SynDataU.elbAngR{i}),max(SynDataU.elbAngR{i})],'--m');
%plot([locH(i) locH(i)],[0,max(ratioU{i})],'--m');
legend('Elbow Angle','Power Ratio')
    end
end
suptitle('Healthy People Shoulder Angle')
groupAll=3*ones(length(SynDataU.EMGR),1);
group=[SynDataA.group;groupAll];
 meanAll1=[meanA3,meanU3];
  meanAll2=[meanA4,meanU4];
locH=locH';
% [Grp1,Grp2,Grp3,Grp4]=group4(SynDataA.group);
%  p14=anova1(meanAll1,group);
%  p15=anova1(meanAll2,group);
%  p13=anova1(meanA,SynDataA.group);
%  p11=anova1(meanA3,SynDataA.group);
%   p12=anova1(meanA4,SynDataA.group);
 [groupby,Grp1,Grp2]=group2(SynDataA.group,LABEL);

group22=[groupby';groupAll];
 p16=anova1(meanAll2,group22);
[p1,p2]=grorpBarPlot(SynDataA.group,LABEL,meanA1,meanA2,meanU1,meanU2);
[p3,p4]=grorpBarPlot(SynDataA.group,LABEL,meanA3',meanA4',meanU3',meanU4');     %ratio
[h2,p5]=ttest2(meanA3(Grp1),meanU3);
[h2,p6]=ttest2(meanA3(Grp2),meanU3);
[h2,p7]=ttest2(meanA4(Grp1),meanU4);
[h2,p8]=ttest2(meanA4(Grp2),meanU4);
[h2,p9]=ttest2(meanA4(Grp1),meanA4(Grp2));