close all;clear ;clc
load('../../DATA/SynDataA_div');

addpath('../../SignalProcess')
addpath('../../feature')
cE=[];
cS=[];
for i=1:length(SynDataA.EMG)
    
    SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
    iEMGA{i}=winRMS(SynDataA.EMG{i},20);
    
    rA{i}=iEMGA{i}(:,3)./iEMGA{i}(:,2); %���Ǽ�ǰ�顢б����
    r1A{i}=iEMGA{i}(:,5)./iEMGA{i}(:,6); %�Ŷ�������
    r2A{i}=iEMGA{i}(:,3)./iEMGA{i}(:,4); %���Ǽ�ǰ�顢����
    meanA(i)=mean(rA{i});
    mean1A(i)=mean(r1A{i});
    mean2A(i)=mean(r2A{i});
   cE=[cE SynDataA.divE{i}];
   cS=[cS SynDataA.divS{i}];
end
divE=cE(find(cE));
divS=cS(find(cS));
m1=meanA(find(cE));
m2=mean1A(find(cE));
m3=mean2A(find(cE));
% mdata(1)=mean(divE);
% sdata(1)=std(divE,1);
% mdata(2)=mean(divS);
% sdata(2)=std(divS,1);
% mdata(3)=mean(m1);
% sdata(3)=std(m1,1);
% mdata(4)=mean(m2);
% sdata(4)=std(m2,1);
% mdata(5)=mean(m3);
% sdata(5)=std(m3,1);
 divE(4:6)=[];
 m2(4:6)=[];
 divE(13)=[];
 m2(13)=[];
 divE(17)=[];
 m2(17)=[];
[r(1),p(1)]=corrAnaly(divE','��ؽڷ�ɢ��',m2','�Ŷ�ͷ��/����ͷ��������',0);
[r(2),p(2)]=corrAnaly(divS','��ؽڷ�ɢ��',m1','���Ǽ�ǰ��/б����',1);
[r(3),p(3)]=corrAnaly(divS','��ؽڷ�ɢ��',m3','���Ǽ�ǰ��/���Ǽ�����',1);
