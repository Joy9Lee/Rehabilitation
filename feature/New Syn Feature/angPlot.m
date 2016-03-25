close all; clear ; clc;
% load('../../DATA/SynDataA_39');
% load('../../DATA/SynDataU_25');
load('../../DATA/SynDataA16_M3');
load('../../DATA/SynDataU19_M3');

for i=1:length(SynDataA.name)
    figure(1)
    subplot(5,8,i)
    plot(SynDataA.shdAng{i})
   
    figure(2)
    subplot(5,8,i)
    plot(SynDataA.elbAng{i})
    
end
figure(1)
 suptitle('affect shoulder Angle')
 figure(2)
 suptitle('affect elbow Angle')
 for i=1:length(SynDataU.name)
    figure(3)
    subplot(5,8,i)
    plot(SynDataU.shdAngR{i})
   
    figure(4)
    subplot(5,8,i)
    plot(SynDataU.elbAngR{i})
    
end
figure(3)
 suptitle('healthy shoulder Angle')
 figure(4)
 suptitle('healthy elbow Angle')