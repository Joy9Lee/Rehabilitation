close all;clear ;clc
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
addpath('../../SignalProcess')
addpath('../../feature')
for i=1:length(SynDataA.EMG)
%     iEMG{i}=CiEMG(SynDataA.EMG{i},200);
SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
iEMGA{i}=winRMS(SynDataA.EMG{i},20);
   
    rA{i}=iEMGA{i}(:,3)./iEMGA{i}(:,2); %三角肌前组、斜方肌
    r1A{i}=iEMGA{i}(:,5)./iEMGA{i}(:,6); %肱二、肱三
    r2A{i}=iEMGA{i}(:,3)./iEMGA{i}(:,4); %三角肌前组、中组
    meanA(i)=mean(rA{i});
    mean1A(i)=mean(r1A{i});
    mean2A(i)=mean(r2A{i});
  %  l=min(length(iEMGA{i}),length(SynDataA.elbAng{i}));
  % [r(i),p(i)]=corrAnaly(r1A{i}(1:l),'ratio',SynDataA.elbAng{i}(1:l),'elbAng');   %斜方肌&三角肌前组
  % [r2(i),p2(i)]=corrAnaly(iEMGA{i}(:,5),'muscle 3',iEMGA{i}(:,6),'muscle 2',1);   %肱二头肌&肱三头肌
    
    if 0
        figure(1)
        subplot(5,8,i)
        plot(iEMG{i}(:,5:6))
        %plot(ratioa{i})
        ylim([0 50000])
        title(['FM' num2str(SynDataA.FM(i))]);
        %      title(['Group' num2str(SynDataA.group(i))]);
        legend('5','6')
        hold on
        %      x=SynDataA.loc(i)/10*ones(11);
        %      y=[0:1000:10000];
        %      plot(x,y)
        figure(3)
        subplot(5,8,i)
        plot(r1A{i})
        hold on
        plot(r1A{i})
        title(['Group' num2str(SynDataA.group(i))]);
        
        
    end
end
 
% figure(1)
% legend('2','3')
for i=1:length(SynDataU.EMGR)
    iEMGU{i}=winRMS(SynDataU.EMGR{i},20);
    rU{i}=iEMGU{i}(:,3)./iEMGU{i}(:,2);
    r1U{i}=iEMGU{i}(:,5)./iEMGU{i}(:,6);
     r2U{i}=iEMGU{i}(:,3)./iEMGU{i}(:,4);
    meanU(i)=mean(rU{i});
    mean1U(i)=mean(r1U{i});
     mean2U(i)=mean(r2U{i});
    %   [r1(i),p1(i)]=corrAnaly(iEMGU{i}(:,3),'muscle 3',iEMGU{i}(:,2),'muscle 2');
    
    if 0
        figure(2)
        subplot(5,5,i)
        plot(iEMGU{i}(:,2:3))
        ylim([0 50000])
        figure(4)
        subplot(5,5,i)
        plot(rU{i})
        title(['Group=' num2str(SynDataA.group(i))]);
        
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
 [Mdata,Sdata,p1]=diffAnaly(meanA,'Affected side',meanU,'Control','三角肌前组与斜方肌平均作功比',1);
 [Mdata2,Sdata2,p2]=diffAnaly(mean1A,'Affected side',mean1U,'Control','肱二头肌与肱三头肌平均作功比',1);
 [Mdata3,Sdata3,p3]=diffAnaly(mean2A,'Affected side',mean2U,'Control','三角肌前组与中组平均作功比',1);


[r3,p7]=corrAnaly(SynDataA.FM,'Fugl-Meyer评分',log(meanA'),'患者三角肌前组与斜方肌平均作功比',1);
%[r3,p7]=corrAnaly(SynDataA.FM,'Fugl-Meyer评分',meanA','患者三角肌前组与斜方肌平均作功比',1);

%% corr of muscle 2&3
%[Mdata,Sdata,p1]=diffAnaly2(r,'Affected side',r1,'Control','平均相关系数',1);

%[r4,p4]=corrAnaly(SynDataA.FM,'Fugl-Meyer评分',r','患者患侧两肌肉做功相关系数',1);
if 0
    figure
    plot(r,'*b')
    hold on
    plot(r1,'.r')
end