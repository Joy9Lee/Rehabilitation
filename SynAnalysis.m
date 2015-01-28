%SynAnalysis
addpath('./SignalProcess');
addpath('./DATA');
close all;
clear;
clc;
load('synDataA');
load('synDataU');
%%
for i=1:16
    synDataA(i).sEMG=CiEMG(synDataA(i).sEMG,10);
    synDataA(i).ang.shd.adb=synDataA(i).ang.shd.adb(1:10:length(synDataA(i).sEMG)*10);
end

for i=1:10
    synDataU(i).sEMG=CiEMG(synDataU(i).sEMG,10);
    synDataU(i).ang.shd.adb=synDataU(i).ang.shd.adb(1:10:length(synDataU(i).sEMG)*10);
end

figure;
for i=1:16
    Ang=mapminmax(synDataA(i).ang.shd.adb',0,synDataA(i).ang.shd.adb(end)/90)';
    subplot(4,4,i)
    deltPtrap=synDataA(i).sEMG(:,2)./(synDataA(i).sEMG(:,2)+synDataA(i).sEMG(:,1));
    bicTri=synDataA(i).sEMG(:,3)./(synDataA(i).sEMG(:,3)+synDataA(i).sEMG(:,4));
    plot(Ang*90,deltPtrap,'r',Ang*90,bicTri,'g');
    hleg=legend('三角肌前组/（三角肌前组+斜方肌）','二头肌/(二头肌+三头肌)');
    set(hleg,'Fontsize',6);
    xlabel('关节角');
    ylim([0 1]);
    S=num2str(synDataA(i).FM);
    S=['FM=',S];
    title(S);
end

figure;
for i=1:10
    Ang=mapminmax(synDataU(i).ang.shd.adb',0,synDataU(i).ang.shd.adb(end)/90)';
    subplot(5,2,i)
    deltPtrap=synDataU(i).sEMG(:,2)./(synDataU(i).sEMG(:,2)+synDataU(i).sEMG(:,1));
    bicTri=synDataU(i).sEMG(:,3)./(synDataU(i).sEMG(:,3)+synDataU(i).sEMG(:,4));
    plot(Ang*90,deltPtrap,'r',Ang*90,bicTri,'g');
    hleg=legend('三角肌前组/（三角肌前组+斜方肌）','二头肌/(二头肌+三头肌)');
    set(hleg,'Fontsize',6);
    xlabel('关节角');
    ylim([0 1]);
   % title('左手患侧');
end