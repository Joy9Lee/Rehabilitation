close all; clear; clc;
load('../DATA/cmpEMGA');
load('../DATA/cmpEMGH');
addpath('G:\SNARC\Rehabilitation\feature');
addpath('G:\SNARC\Rehabilitation\SignalProcess');
N=3;
display=0;
for i=1:length(cmpEMGA.name)            %affect
    cmpEMGA.EMG{i}=PreProcess(cmpEMGA.EMG{i});
    cmpEMGA.EMGU{i}=PreProcess(cmpEMGA.EMGU{i});
    [H{i},W{i},R(i),D(i)]=ExtractSynergy(cmpEMGA.EMG{i},N,20);
 %   [H2{i},W2,R2(i),D2(i)]=ExtractSynergy(cmpEMGA.EMGU{i},N,20);
   
end
for i=1:length(cmpEMGA.name)            %affect
    for j= i+1:length(cmpEMGA.name)
        [sim{i,j},m{i,j},s1{i,j}]=synergySim(H{i},H{j},N);
    end
end
 