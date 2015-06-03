close all
clear all
clc
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');
addpath('../../SignalProcess')
addpath('../../feature')
for i=1:length(SynDataA.EMG)
    iEMG{i}=CiEMG(SynDataA.EMG{i},200);
    rA{i}=iEMG{i}(:,3)./iEMG{i}(:,2);
    r1A{i}=iEMG{i}(:,5)./iEMG{i}(:,6);
    meanA(i)=mean(rA{i});
    mean1A(i)=mean(r1A{i});
    [r(i),p(i)]=corrAnaly(iEMG{i}(:,3),'muscle 3',iEMG{i}(:,2),'muscle 2');   %斜方肌&三角肌前组
    [r2(i),p2(i)]=corrAnaly(iEMG{i}(:,5),'muscle 3',iEMG{i}(:,6),'muscle 2');   %肱二头肌&肱三头肌

     if 1
    figure(1)
    subplot(5,5,i)
    plot(iEMG{i}(:,2:3))
    %plot(ratioa{i})
     ylim([0 50000])
     title(['FM=' num2str(SynDataA.FM(i))]);
     hold on 
     x=SynDataA.loc(i)/10*ones(11);
     y=[0:1000:10000];
     plot(x,y)
     figure(3)
     subplot(5,5,i)
     plot(rA{i})
     
     end
end
% figure(1)
% legend('2','3')
for i=1:length(SynDataU.EMG)
    iEMGU{i}=CiEMG(SynDataU.EMG{i},200);
    rU{i}=iEMGU{i}(:,3)./iEMGU{i}(:,2);
    r1U{i}=iEMGU{i}(:,5)./iEMGU{i}(:,6);
    meanU(i)=mean(rU{i});
    mean1U(i)=mean(r1U{i});
   [r1(i),p1(i)]=corrAnaly(iEMGU{i}(:,3),'muscle 3',iEMGU{i}(:,2),'muscle 2');

    if 0
    figure(2)
    subplot(5,5,i)
    plot(iEMGU{i}(:,2:3))
    ylim([0 50000])
    figure(4)
    subplot(5,5,i)
    plot(rU{i}) 
    title(['FM=' num2str(SynDataA.FM(i))]);
    
    end
end
if 0
figure(5)
    
    plot(r,'b*') 
    hold on
    plot(r1,'r.')
    hold on
end
%% power ratio
[Mdata,Sdata,p1]=diffAnaly2(meanA,'Affected side',meanU,'Control','三角肌前组与斜方肌平均作功比',1);
[Mdata,Sdata,p2]=diffAnaly2(mean1A,'Affected side',mean1U,'Control','肱二头肌与肱三头肌平均作功比',1);



%[r3,p7]=corrAnaly(SynDataA.FM,'Fugl-Meyer评分',log(meanA'),'患者三角肌前组与斜方肌平均作功比',1);
[r3,p7]=corrAnaly(SynDataA.FM,'Fugl-Meyer评分',meanA','患者三角肌前组与斜方肌平均作功比',1);

%% corr of muscle 2&3
[Mdata,Sdata,p1]=diffAnaly2(r,'Affected side',r1,'Control','平均相关系数',1);

[r4,p4]=corrAnaly(SynDataA.FM,'Fugl-Meyer评分',r','患者患侧两肌肉做功相关系数',1);
if 0
figure 
plot(r,'*b')
hold on
plot(r1,'.r')
end