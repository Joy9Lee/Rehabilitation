close all; clear ; clc;
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
load('../../DATA/locA');
load('../../DATA/locH');
for i=1:length(SynDataA.name)
    figure(1)
    subplot(5,8,i)
    plot(SynDataA.shdAng{i},'b')
   hold on
   plot(SynDataA.elbAng{i},'r')  
   hold on;
    plot([locA(i) locA(i)],[min(SynDataA.shdAng{i}),max(SynDataA.shdAng{i})],'--m');
    
end

 for i=1:length(SynDataU.name)
    figure(2)
    subplot(5,8,i)
    plot(SynDataU.shdAngR{i},'b')
    hold on
    plot(SynDataU.elbAngR{i},'r')
    
end
figure(1)
 suptitle('Patients')
 figure(2)
 suptitle('Health')