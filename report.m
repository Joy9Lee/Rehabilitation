%SynAnalysis
%16例医院要的旧方式的统计结果
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
%% 计算角度变化率
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
    %% 肩关节角
    figure
    subplot(3,2,1);
    set (gcf,'Position',[400,100,800,500], 'color','w')
    plot(tA,AngShdA,'b',tA,dAngShdA,'k',tU,AngShdU,'r',tU,dAngShdU,'g');
%     hleg=legend('患组肩关节角','患组肩关节角度变化率','正常组肩关节角','正常组肩关节角角度变化率');
%     set(hleg,'Fontsize',8);
    xlabel('时间/s');
    ylabel('角度')
    ylim([-10 90]);
    title('肩关节角');
    %% 斜方肌与三角肌
    subplot(3,2,2);
    set (gcf,'Position',[400,100,800,500], 'color','w')
    plot(tA,AngElbA,'b',tA,dAngElbA,'k',tU,AngElbU,'r',tU,dAngElbU,'g');
%     hleg=legend('患组肘关节角','患组肘关节角度变化率','正常组肘关节角','正常组肘关节角角度变化率');
%     set(hleg,'Fontsize',8);
    xlabel('时间/s');
    ylabel('角度')
    ylim([-20 60]);
    title('肘关节角');
    %% 斜方肌与三角肌做功
    subplot(3,2,3);
    set (gcf,'Position',[400,100,800,500], 'color','w')
    plot(tA,synDataA(i).sEMG(:,1)/5,'b',tA,synDataA(i).sEMG(:,2)/5,'k',tU,synDataU(7).sEMG(:,1)/5,'r',tU,synDataU(7).sEMG(:,2)/5,'g');
%     hleg=legend('患组斜方肌做功','患组三角肌做功','正常组斜方肌做功','正常组三角肌做功');
%     set(hleg,'Fontsize',8);
    xlabel('时间/s');
    ylabel('做功/10e-6 J')
    title('斜方肌与三角肌做功');
    %% 二头肌与三头肌做功
    subplot(3,2,4);
    set (gcf,'Position',[400,100,800,500], 'color','w')
    plot(tA,synDataA(i).sEMG(:,3)/5,'b',tA,synDataA(i).sEMG(:,4)/5,'k',tU,synDataU(7).sEMG(:,3)/5,'r',tU,synDataU(7).sEMG(:,4)/5,'g');
%     hleg=legend('患组二头肌做功','患组三头做功','正常组二头肌做功','正常组三头肌做功');
%     set(hleg,'Fontsize',8);
    xlabel('时间/s');
    ylabel('做功/10e-6 J')
    title('二头肌与三头肌做功');
    %% 三角肌前组/斜方肌
    subplot(3,2,5);
    set (gcf,'Position',[400,100,800,500], 'color','w')
    plot(tA,deltPtrapA,'b',tU,deltPtrapU,'k');
%     hleg=legend('患组三角肌前组/斜方肌','正常组三角肌前组/斜方肌');
%     set(hleg,'Fontsize',8);
    xlabel('时间/s');
    ylabel('做功/10e-6 J')
    title('三角肌前组/斜方肌');
    %% 肱二头/肱三头
    subplot(3,2,6);
    set (gcf,'Position',[400,100,800,500], 'color','w')
    plot(tA,bicTriA,'b',tU,bicTriU,'k');
%     hleg=legend('患组肱二头/肱三头','正常组肱二头/肱三头');
%     set(hleg,'Fontsize',8);
    xlabel('时间/s');
    ylabel('做功/10e-6 J')
    title('肱二头肌/肱三头肌肉');
%%
    ax = axes('position',[0,0,1,1],'visible','off');
    str1=cell2mat(synDataA(i).name);
    SC=sprintf('%s  FM=%d',str1,synDataA(i).FM)
    tx = text(0.4,0.03,SC);

    set(tx,'fontweight','bold');
end