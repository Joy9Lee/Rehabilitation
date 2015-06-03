close all
clear all
clc
load('../../DATA/bothSideA');
load('../../DATA/SynDataU');
addpath('../../SignalProcess')
addpath('../../feature')
SynDataA=bothSideA;
for i=1:length(SynDataA.EMGA)
    iEMGA{i}=CiEMG(SynDataA.EMGA{i},200);
    rA{i}=iEMGA{i}(:,3)./iEMGA{i}(:,2);
    r1A{i}=iEMGA{i}(:,5)./iEMGA{i}(:,6);
    meanA(i)=mean(rA{i});
    mean1A(i)=mean(r1A{i});
    [r(i),p(i)]=corrAnaly(iEMGA{i}(:,3),'muscle 3',iEMGA{i}(:,2),'muscle 2');   %б����&���Ǽ�ǰ��
    [r2(i),p2(i)]=corrAnaly(iEMGA{i}(:,5),'muscle 3',iEMGA{i}(:,6),'muscle 2');   %�Ŷ�ͷ��&����ͷ��
    iEMGU{i}=CiEMG(SynDataA.EMGU{i},200);
    rU{i}=iEMGU{i}(:,3)./iEMGU{i}(:,2);
    r1U{i}=iEMGU{i}(:,5)./iEMGU{i}(:,6);
    meanU(i)=mean(rU{i});
    mean1U(i)=mean(r1U{i});
    [r3(i),p3(i)]=corrAnaly(iEMGU{i}(:,3),'muscle 3',iEMGU{i}(:,2),'muscle 2');   %б����&���Ǽ�ǰ��
    [r4(i),p4(i)]=corrAnaly(iEMGU{i}(:,5),'muscle 3',iEMGU{i}(:,6),'muscle 2');   %�Ŷ�ͷ��&����ͷ��

    if 1
    figure(1)
    subplot(5,5,i)
    plot(iEMGA{i}(:,2:3))
    %plot(ratioa{i})
     ylim([0 50000])
     title(['FM=' num2str(SynDataA.FM(i))]);
   
     figure(2)
     subplot(5,5,i)
     plot(rA{i})
     title(['FM=' num2str(SynDataA.FM(i))]);
    figure(3)
    subplot(5,5,i)
    plot(iEMGU{i}(:,2:3))
    %plot(ratioa{i})
    
     title(['FM=' num2str(SynDataA.FM(i))]);
     
    
     figure(4)
     subplot(5,5,i)
     plot(rU{i})
     title(['FM=' num2str(SynDataA.FM(i))]);
     end
end
% figure(1)
% legend('2','3')
for i=1:length(SynDataU.EMG)
    iEMGC{i}=CiEMG(SynDataU.EMG{i},200);
    rC{i}=iEMGC{i}(:,3)./iEMGC{i}(:,2);
    r1C{i}=iEMGC{i}(:,5)./iEMGC{i}(:,6);
    meanC(i)=mean(rC{i});
    mean1C(i)=mean(r1C{i});
   [r5(i),p5(i)]=corrAnaly(iEMGC{i}(:,3),'muscle 3',iEMGC{i}(:,2),'muscle 2');  %б����&���Ǽ�ǰ��

    if 1
    figure(5)
    subplot(5,5,i)
    plot(iEMGC{i}(:,2:3))
    ylim([0 50000])
    figure(6)
    subplot(5,5,i)
    plot(rC{i}) 
    
    
    end
end
if 0
figure(5)
    
    plot(r,'b*') 
    hold on
    plot(r3,'r.')
    hold on
     plot(r5,'c.')
    hold on
end
%% power ratio
[Mdata,Sdata,p1]=diffAnaly(meanA,'Affected side',meanU,'Unaffected side',meanC,'Control','���Ǽ�ǰ����б����ƽ��������',1);
[Mdata,Sdata,p2]=diffAnaly(mean1A,'Affected side',mean1U,'Unaffected side',meanC,'Control','�Ŷ�ͷ��������ͷ��ƽ��������',1);



%[r3,p7]=corrAnaly(SynDataA.FM,'Fugl-Meyer����',log(meanA'),'�������Ǽ�ǰ����б����ƽ��������',1);
[r6,p6]=corrAnaly(SynDataA.FM,'Fugl-Meyer����',meanA','�������Ǽ�ǰ����б����ƽ��������',1);

%% corr of muscle 2&3
[Mdata,Sdata,p1]=diffAnaly(r,'Affected side',r3,'Unaffected side',r5,'Control','ƽ�����ϵ��',1);

[r7,p7]=corrAnaly(SynDataA.FM,'Fugl-Meyer����',r','���߻����������������ϵ��',1);
if 0
figure 
plot(r,'*b')
hold on
plot(r1,'.r')
end