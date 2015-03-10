%report to hospital, display the synchronous sEMG and kinetic data of each
%side of normal and each side of patient.
clear all;
clc;
close all;

load('..\DATA\backup\DataA-35');
load('..\DATA\backup\DataU-11');

emgNR = DataU(3).R.flx.sEMG{1};
kinNR = DataU(3).R.flx.kin(1).limb{2};
emgNL = DataU(3).L.flx.sEMG{1};
kinNL = DataU(3).L.flx.kin(1).limb{2};
emgUR = DataA(28).R.flx.sEMG{1};
kinUR = DataA(28).R.flx.kin(1).limb{2};
emgAL = DataA(28).L.flx.sEMG{1};
kinAL = DataA(28).L.flx.kin(1).limb{2};
[angNR deltPtrapNR bicTriNR] = process(kinNR, emgNR);
[angNL deltPtrapNL bicTriNL] = process(kinNL, emgNL);
[angUR deltPtrapUR bicTriUR] = process(kinUR, emgUR);
[angAL deltPtrapAL bicTriAL] = process(kinAL, emgAL);

tNRk = (1:length(angNR))./50;
tNLk = (1:length(angNL))./50;
tURk = (1:length(angUR))./50;
tALk = (1:length(angAL))./50;
tNRe = (1:length(deltPtrapNR))./10;
tNLe = (1:length(deltPtrapNL))./10;
tURe = (1:length(deltPtrapUR))./10;
tALe = (1:length(deltPtrapAL))./10;
subplot(3,1,1)
plot(tNRk,angNR,tNLk,angNL,tURk,angUR,tALk,angAL);
legend('健康人右手','健康人左手','患者右手','患者左手');
xlabel('时间/s');
ylabel('角度')
title('肩关节运动角度');
subplot(3,1,2)
plot(tNRe,deltPtrapNR,tNLe,deltPtrapNL,tURe,deltPtrapUR,tALe,deltPtrapAL);
legend('健康人右手','健康人左手','患者右手','患者左手');
xlabel('时间/s');
ylabel('比例')
title('三角肌前组与斜方肌做功比');
subplot(3,1,3)
plot(tNRe,bicTriNR,tNLe,bicTriNL,tURe,bicTriUR,tALe,bicTriAL);
legend('健康人右手','健康人左手','患者右手','患者左手');
xlabel('时间/s');
ylabel('比例')
title('肱二头肌与肱三头肌做功比');