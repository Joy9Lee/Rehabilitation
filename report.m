%SynAnalysis
%16��ҽԺҪ�ľɷ�ʽ��ͳ�ƽ��
addpath('./SignalProcess');
addpath('./DATA');
close all;
clear;
clc;
load('DATA/synDataA');
load('DATA/synDataU');
%%
for i=1:16
    synDataA(i).sEMG=CiEMG(synDataA(i).sEMG,10);
    synDataA(i).ang.shd.adb=synDataA(i).ang.shd.adb(1:10:length(synDataA(i).sEMG)*10);
    synDataA(i).ang.elb.adb=synDataA(i).ang.elb.adb(1:10:length(synDataA(i).sEMG)*10);
end

for i=1:10
    synDataU(i).sEMG=CiEMG(synDataU(i).sEMG,10);
    synDataU(i).ang.shd.adb=synDataU(i).ang.shd.adb(1:10:length(synDataU(i).sEMG)*10);
    synDataU(i).ang.elb.adb=synDataU(i).ang.elb.adb(1:10:length(synDataU(i).sEMG)*10);
end

 AngShdU=mapminmax(synDataU(7).ang.shd.adb',0,synDataU(7).ang.shd.adb(end))';
 AngElbU=mapminmax(synDataU(7).ang.elb.adb',0,synDataU(7).ang.elb.adb(end))';
 deltPtrapU=synDataU(7).sEMG(:,2)./(synDataU(7).sEMG(:,2)+synDataU(7).sEMG(:,1));
 bicTriU=synDataU(7).sEMG(:,3)./(synDataU(7).sEMG(:,3)+synDataU(7).sEMG(:,4));
 
%% time sequence
tU=1:length(synDataU(7).sEMG);
tU=tU/1000*200;
%% ����Ƕȱ仯��
dAngShdU=[0;diff(AngShdU)];
dAngElbU=[0;diff(AngElbU)];
for i=1:16
    AngShdA=mapminmax(synDataA(i).ang.shd.adb',0,synDataA(i).ang.shd.adb(end))';
    AngElbA=mapminmax(synDataA(i).ang.elb.adb',0,synDataA(i).ang.elb.adb(end))';
    deltPtrapA=synDataA(i).sEMG(:,2)./(synDataA(i).sEMG(:,2)+synDataA(i).sEMG(:,1));
    bicTriA=synDataA(i).sEMG(:,3)./(synDataA(i).sEMG(:,3)+synDataA(i).sEMG(:,4));
    dAngShdA=[0;diff(AngShdA)];
    dAngElbA=[0;diff(AngElbA)];
    tA=1:length(synDataA(i).sEMG);
    tA=tA/1000*200;
    %% ��ؽڽ�
    figure
    subplot(3,2,1);
    set (gcf,'Position',[400,100,800,500], 'color','w')
    plot(tA,AngShdA,'b',tA,dAngShdA,'k',tU,AngShdU,'r',tU,dAngShdU,'g');
%     hleg=legend('�����ؽڽ�','�����ؽڽǶȱ仯��','�������ؽڽ�','�������ؽڽǽǶȱ仯��');
%     set(hleg,'Fontsize',8);
    xlabel('ʱ��/s');
    ylabel('�Ƕ�')
    ylim([-10 90]);
    title('��ؽڽ�');
    %% б���������Ǽ�
    subplot(3,2,2);
    set (gcf,'Position',[400,100,800,500], 'color','w')
    plot(tA,AngElbA,'b',tA,dAngElbA,'k',tU,AngElbU,'r',tU,dAngElbU,'g');
%     hleg=legend('������ؽڽ�','������ؽڽǶȱ仯��','��������ؽڽ�','��������ؽڽǽǶȱ仯��');
%     set(hleg,'Fontsize',8);
    xlabel('ʱ��/s');
    ylabel('�Ƕ�')
    ylim([-20 60]);
    title('��ؽڽ�');
    %% б���������Ǽ�����
    subplot(3,2,3);
    set (gcf,'Position',[400,100,800,500], 'color','w')
    plot(tA,synDataA(i).sEMG(:,1)/5,'b',tA,synDataA(i).sEMG(:,2)/5,'k',tU,synDataU(7).sEMG(:,1)/5,'r',tU,synDataU(7).sEMG(:,2)/5,'g');
%     hleg=legend('����б��������','�������Ǽ�����','������б��������','���������Ǽ�����');
%     set(hleg,'Fontsize',8);
    xlabel('ʱ��/s');
    ylabel('����/10e-6 J')
    title('б���������Ǽ�����');
    %% ��ͷ������ͷ������
    subplot(3,2,4);
    set (gcf,'Position',[400,100,800,500], 'color','w')
    plot(tA,synDataA(i).sEMG(:,3)/5,'b',tA,synDataA(i).sEMG(:,4)/5,'k',tU,synDataU(7).sEMG(:,3)/5,'r',tU,synDataU(7).sEMG(:,4)/5,'g');
%     hleg=legend('�����ͷ������','������ͷ����','�������ͷ������','��������ͷ������');
%     set(hleg,'Fontsize',8);
    xlabel('ʱ��/s');
    ylabel('����/10e-6 J')
    title('��ͷ������ͷ������');
    %% ���Ǽ�ǰ��/б����
    subplot(3,2,5);
    set (gcf,'Position',[400,100,800,500], 'color','w')
    plot(tA,deltPtrapA,'b',tU,deltPtrapU,'k');
%     hleg=legend('�������Ǽ�ǰ��/б����','���������Ǽ�ǰ��/б����');
%     set(hleg,'Fontsize',8);
    xlabel('ʱ��/s');
    ylabel('����/10e-6 J')
    title('���Ǽ�ǰ��/б����');
    %% �Ŷ�ͷ/����ͷ
    subplot(3,2,6);
    set (gcf,'Position',[400,100,800,500], 'color','w')
    plot(tA,bicTriA,'b',tU,bicTriU,'k');
%     hleg=legend('�����Ŷ�ͷ/����ͷ','�������Ŷ�ͷ/����ͷ');
%     set(hleg,'Fontsize',8);
    xlabel('ʱ��/s');
    ylabel('����/10e-6 J')
    title('�Ŷ�ͷ��/����ͷ����');
%%
    ax = axes('position',[0,0,1,1],'visible','off');
    str1=cell2mat(synDataA(i).name);
    SC=sprintf('%s  FM=%d',str1,synDataA(i).FM)
    tx = text(0.4,0.03,SC);

    set(tx,'fontweight','bold');
end