close all; clear ; clc;
load('Hn_min');
load('Na')
load('../DATA/SynDataA_35');
addpath('../SignalProcess');
addpath('../feature')
for i=1:length(SynDataA.EMG)            %affect
    NA=Na(i);
    SynDataA.EMG{i}=PreProcess(SynDataA.EMG{i});
    SynDataA.EMGU{i}=PreProcess(SynDataA.EMGU{i});
    [W{i}, H{i},R(i),D(i)]=ExtractSynergy(SynDataA.EMG{i},NA,1000,5);
    [W2{i},H2{i},R2(i),D2(i)]=ExtractSynergy(SynDataA.EMGU{i},NA,1000,5);
    [sim{i},m{i},s1{i}]=patternSim(Hn,H{i},NA);
end
