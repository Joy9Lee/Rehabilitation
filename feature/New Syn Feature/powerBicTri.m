close all; clear ; clc;
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
addpath('../../SignalProcess');
addpath('../../feature')
for i=1:length(SynDataA.name)
    %     iEMGA{i}=CiEMG(SynDataA.EMG{i},200);
    iEMGA{i}=winRMS(SynDataA.EMG{i},20);
%     rA{i}=iEMGA{i}(:,2)./iEMGA{i}(:,3);
     rA{i}=iEMGA{i}(:,3)./iEMGA{i}(:,2);
    r1A{i}=iEMGA{i}(:,5)./iEMGA{i}(:,6);
    %r1A{i}=iEMGA{i}(:,6)./iEMGA{i}(:,5);
    meanA(i)=mean(rA{i});
    mean1A(i)=mean(r1A{i});
    if 0
        figure
        plot(r1A{i})
    end
end

for i=1:length(SynDataU.name)
%     iEMGU{i}=CiEMG(SynDataU.EMGR{i},200);
    iEMGU{i}=winRMS(SynDataU.EMGR{i},20);
%     rU{i}=iEMGU{i}(:,2)./iEMGU{i}(:,3);
     rU{i}=iEMGU{i}(:,3)./iEMGU{i}(:,2);
     r1U{i}=iEMGU{i}(:,5)./iEMGU{i}(:,6);
  %   r1U{i}=iEMGU{i}(:,6)./iEMGU{i}(:,5);
    meanU(i)=mean(rU{i});
    mean1U(i)=mean(r1U{i});
end
Grp1=[]; Grp2=[]; Grp3=[]; Grp4=[];
for i =1 : length(SynDataA.FM)
    switch SynDataA.group(i)
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
%meanA=meanA';
[Mdata1,Sdata1,p1] = diffAnaly4(meanA(Grp1),'Grp1',meanA(Grp2),'Grp2',meanA(Grp3),'Grp3',meanA(Grp4),'Grp4',meanU,'Control','三角肌前组/斜方肌作功比',1);
[Mdata,Sdata,p3] = diffAnaly4(mean1A(Grp1),'Grp1',mean1A(Grp2),'Grp2',mean1A(Grp3),'Grp3',mean1A(Grp4),'Grp4',mean1U,'Control','肱二头肌/肱三头肌作功比',1);

