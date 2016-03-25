close all; clear ; clc;
%load('../../DATA/SynDataA');
% load('../../DATA/SynDataA_39');
% load('../../DATA/SynDataU_25');
load('../../DATA/SynDataA16_M3');
load('../../DATA/SynDataU19_M3');

load('../../DATA/locA');
load('../../DATA/locH');
addpath('G:\SNARC\Rehabilitation\SignalProcess');
addpath('../../feature');
for i=1:length(SynDataA.name)
    
    maxSAngA(i)=max(SynDataA.shdAng{i});
    maxEAngA(i)=max(SynDataA.elbAng{i});
%     angSA1{i}=SynDataA.shdAng{i}(1:locA(i)-1);
%     angSA2{i}=SynDataA.shdAng{i}(locA(i):end);
%     angEA1{i}=SynDataA.elbAng{i}(1:locA(i)-1);
%     angEA2{i}=SynDataA.elbAng{i}(locA(i):end);
%     meanSAngA(i)=mean(angSA2{i});
%     meanEAngA(i)=mean(angEA2{i});
end
for i=1:length(SynDataU.name)
    maxSAngU(i)=max(SynDataU.shdAngR{i});
    maxEAngU(i)=max(SynDataU.elbAngR{i});
%     angSU1{i}=SynDataU.shdAngR{i}(1:locH(i)-1);
%     angSU2{i}=SynDataU.shdAngR{i}(locH(i):end);
%     angEU1{i}=SynDataU.elbAngR{i}(1:locA(i)-1);
%     angEU2{i}=SynDataU.elbAngR{i}(locA(i):end);
%     meanSAngU(i)=mean(angSU2{i});
%     meanEAngU(i)=mean(angEU2{i});
end
 [Mdata,Sdata,p]=diffAnaly(maxSAngA,'Patients Group',maxSAngU,'Control Group','Maximum Shoulder Angle/degree',1);
% [r,p2]=corrAnaly(SynDataA.FM(1:33),'Fugl-Meyer Score',maxSAngA','Maximum Shoulder Angle/degree',1)
 [r,p2]=corrAnaly(SynDataA.FM,'Fugl-Meyer Score',maxSAngA','Maximum Shoulder Angle/degree',1)
group2=5*ones(length(SynDataU.EMGR),1);
[Grp1,Grp2,Grp3,Grp4]=group4(SynDataA.group);
group2=[SynDataA.group;group2];
Mdata=[maxSAngA maxSAngU];
%Mdata=[maxEAngA maxEAngU];
% meanSAng=[meanSAngA,meanSAngU];
% meanEAng=[meanEAngA,meanEAngU];
%p1=anova1(meanEAng,group2);
title( 'Shoulder Angle')
xlabel('Group')
ylabel('Shoulder Angle/ degree')
%p2=anova1(meanEAng,group2);
p=anova1(Mdata,group2);
[Mdata,Sdata,p]=ErrorbarPlot5(maxSAngA(Grp1),'Grp1',maxSAngA(Grp2),'Grp2',maxSAngA(Grp3),'Grp3',maxSAngA(Grp4),'Grp4',maxSAngU,'Healthy','Shoulder Angle/ degree',1)
title( 'Shoulder Angle')
ylabel('Shoulder Angle/ degree')
maxSAngA
[Mdata,Sdata,p1]=diffAnaly(maxEAngA,'Affected side',maxEAngU,'Control','Elbow Angle',1);
