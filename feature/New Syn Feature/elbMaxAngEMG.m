close all; clear ; clc;
%load('../../DATA/SynDataA');
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
load('../../DATA/locA');
load('../../DATA/locH');
addpath('../../SignalProcess');
addpath('../../feature');
idA=[];
idU=[];
ratioA={};
for i=1:length(SynDataA.name)
  %  [maxSAngA(i),indexA(i)]=max(SynDataA.shdAng{i});
   [maxEAngA(i),indexA(i)]=max(SynDataA.elbAng{i});
    SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
    EMGA{i}=winRMS(SynDataA.EMG{i},20);
    ratioA{i}=EMGA{i}(:,5)./EMGA{i}(:,6);
    if indexA(i)+5<length(ratioA{i})
        maxrA(i)=ratioA{i}(indexA(i)+5);
        %maxrA(i)=ratioA{i}(indexA(i));
    else
        maxrA(i)=0;
    end
    if 1
        figure(1)
        subplot(5,8,i)
        plot(SynDataA.elbAng{i},'r')
        hold on
        plot(ratioA{i},'b')
        hold on
        plot([indexA(i)+5 indexA(i)+5],[0,50],'--g');
        hold on
        plot([locA(i) locA(i)],[0,50],'--m');
        ylim([0 50])
        %  title(['Grp=' num2str(SynDataA.group(i))]);
        title(['FM=' num2str(SynDataA.FM(i))]);
    end
    if indexA(i)<(3/4)*length(SynDataA.elbAng{i})
        idA=[idA i];
    end
end
indexA=indexA';

for i=1:length(SynDataU.name)
    
   % maxSAngU(i)=max(SynDataU.shdAngR{i});
    [maxEAngU(i),indexU(i)]=max(SynDataU.elbAngR{i});
    SynDataU.EMGR{i}=EMGPre(SynDataU.EMGR{i});
    EMGU{i}=winRMS(SynDataU.EMGR{i},20);
    ratioU{i}=EMGU{i}(:,5)./EMGU{i}(:,6);
    
    if indexU(i)+5<length(ratioU{i})
        maxrU(i)=ratioU{i}(indexU(i)+5);
        %maxrU(i)=ratioU{i}(indexU(i));
    else
        maxrU(i)=0;
    end
    if 1
        figure(5)
        subplot(5,8,i)
        
        plot(SynDataU.elbAngR{i},'r')
        hold on
        plot(ratioU{i},'b')
        hold on
        plot([indexU(i)+5 indexU(i)+5],[0,50],'--g');
        hold on
        ylim([0 50])
        
        plot([locH(i) locH(i)],[0,50],'--m');
    end
    if indexU(i)<(3/4)*length(SynDataU.elbAngR{i})
        idU=[idU i];
    end
end
indexU=indexU';
 maxr=[maxrA(idA) maxrU(idU)];


% group=[ones(1,26) 2*ones(1,20)];
 %[group,Grp1,Grp2]=group2(SynDataA.group,'b');
% p=anova1(maxrA(idA),SynDataA.group(idA));
 p=anova1(maxrA(idA),SynDataA.group(idA));
%p=anova1(maxr,group);
set(gca,'XTickLabel',{'Affected side','Control'})
ylabel('Ratio of Biceps and Triceps' )
Grp1=[]; Grp2=[]; Grp3=[]; Grp4=[];
g=SynDataA.group(idA);
for i =1 : length(idA)
    switch g(i)
        case 1
            Grp1=[Grp1 i];
        case 2
            Grp2=[Grp2 i];
        case 3
            Grp3=[Grp3 i];
        case 4
            Grp4=[Grp4 i];
    end
end

 [Mdata1,Sdata1,p1] = diffAnaly4(maxrA(Grp1),'Grp1',maxrA(Grp2),'Grp2',maxrA(Grp3),'Grp3',maxrA(Grp4),'Grp4',maxrU,'Control','Ratio of Biceps and Triceps',1);
 Mdata1=Mdata1';
 Sdata1=Sdata1';
 [Mdata,Sdata,p2]=diffAnaly(maxrA(idA),'Affected side',maxrU(idU),'Control','Ratio of Biceps and Triceps',1);