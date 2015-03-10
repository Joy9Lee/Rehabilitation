function [ang deltPtrap bicTriA] = process(kin, emg)
addpath('..\SignalProcess');
addpath('..\quaternion');
ang = quatfac(kin);
iEMG = CiEMG(emg,100);
deltPtrap = iEMG(:,3)./iEMG(:,2);
bicTriA = iEMG(:,5)./iEMG(:,6);
ang = ang(1:length(iEMG)*5);