close all; clear all; clc;
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');
addpath('G:\SNARC\肌电资料\康复资料\文档\帅哥\交接\康复评估\Matlab\获取MFI');
addpath('G:\SNARC\肌电资料\康复资料\文档\帅哥\交接\康复评估\Matlab\获取MFI\Quaternion');
addpath('../../SignalProcess');
addpath('../../quaternion')
addpath('../../feature')
fs=50;
figure
angA=jointAng(SynDataA,7,1);
figure
angU=jointAng(SynDataU,7,1);
figure

for i=1:length(SynDataA.name)
    %angA{i}=linear_normalize(angA{i});
    angA{i}=angA{i}/90;
    powRatio{i}=SynDataA.synEMG{i}(:,5)./SynDataA.synEMG{i}(:,6);
    %powRatio{i}=linear_normalize(powRatio{i});
     mA(i)=max(max(SynDataA.synEMG{i}(:,5),SynDataA.synEMG{i}(:,6)));

%     subplot(4,6,i)
%     L(i)=min(length(angA{i}),length(SynDataA.synEMG{i}));
%     t=(1:L(i))/fs;
%     plot(t,angA{i}(1:L(i)))
%     hold on
%     plot(t,powRatio{i}(1:L(i)))
%     [r(i),p(i)]=corrAnaly(angA{i}(1:L(i))','Fugl-Meyer评分',powRatio{i}(1:L(i)),'logVAR',0);
    
end
suptitle('affected Bice/Trice PowerRatio')
for i=1:length(SynDataU.name)
    %angA{i}=linear_normalize(angA{i});
    angU{i}=angU{i}/90;
    powRatioU{i}=SynDataU.synEMG{i}(:,5)./SynDataU.synEMG{i}(:,6);
    mU(i)=max(max(SynDataU.synEMG{i}(:,5),SynDataU.synEMG{i}(:,6)));

    %powRatioU{i}=linear_normalize(powRatioU{i});
    
%     subplot(4,6,i)
%     LU(i)=min(length(angU{i}),length(SynDataU.synEMG{i}));
%     tU=(1:LU(i))/fs;
%     plot(tU,angU{i}(1:L(i)))
%     hold on
%     plot(tU,powRatioU{i})
%     [r(i),p(i)]=corrAnaly(angU{i}(1:LU(i))','Fugl-Meyer评分',powRatioU{i}(1:LU(i)),'logVAR',0);
    
end
suptitle('affected Bice/Trice PowerRatio')



for i=1:length(SynDataA.name)
figure
lA=length(angA{i});
lE=length(SynDataA.synEMG{i});
L(i)=min(lA,lE);
t=(1:L(i))/fs;
 plot(t,angA{i}(1:L(i)),'r')
 xlabel('Time/s')
 hold on
 plot(t,SynDataA.synEMG{i}(1:L(i),5)/7000,'g')
 hold on
 plot(t,SynDataA.synEMG{i}(1:L(i),6)/7000)
 %plot(t,powRatio{i}(1:L(i))/25)

title(strcat('FM=',num2str(SynDataA.FM(i)),SynDataA.name{i}));
%title(SynDataA.name{i});
legend('Elbow Angle','Bice power','Trice Power')
ylim([0 1])
end





for i=1:length(SynDataU.name)
figure
lA=length(angU{i});
lE=length(SynDataU.synEMG{i});
L(i)=min(lA,lE);
t=(1:L(i))/fs;
 plot(t,angU{i}(1:L(i)),'r')
 xlabel('Time/s')
 hold on
 %plot(t,powRatioU{i}(1:L(i))/25)
 plot(t,SynDataU.synEMG{i}(1:L(i),5)/7000,'g')
 hold on
  plot(t,SynDataU.synEMG{i}(1:L(i),6)/7000)
% title(strcat('FM=',num2str(SynDataA.FM(i)),SynDataA.name{i}));
title(SynDataU.name{i});
legend('Elbow Angle','Bice power','Trice Power')
ylim([0 1])
end
figure
plot(r,'*')