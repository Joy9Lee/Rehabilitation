close all; clear; clc;
load('../DATA/SynDataA_39');
load('../DATA/cmpEMGA');
load('../DATA/cmpEMGH');
load('H');
load('HA');
addpath('G:\SNARC\Rehabilitation\feature');
addpath('G:\SNARC\Rehabilitation\SignalProcess');
N=1;
NA=3;
NH=3;
for i=1:length(cmpEMGA.name)            %affect
    
    cmpEMGA.EMG{i}=PreProcess(cmpEMGA.EMG{i});
    cmpEMGA.EMGU{i}=PreProcess(cmpEMGA.EMGU{i});
    [H{i},W{i},R(i),D(i)]=ExtractSynergy(cmpEMGA.EMG{i},NA,1000,5);
    [H2{i},W2{i},R2(i),D2(i)]=ExtractSynergy(cmpEMGA.EMGU{i},NA,1000,5);
end