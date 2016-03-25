close all; clear ; clc;
load('../DATA/cmpEMGA');
load('../DATA/SynDataU_23');
addpath('../SignalProcess');
addpath('../feature')
N=3;
for i=1:length(cmpEMGA.name)
    
    figure
    for j=1:7
        subplot(7,1,j)
        plot(cmpEMGA.EMG{i}(:,j))
    end
    cmpEMGA.EMG{i}=PreProcess(cmpEMGA.EMG{i});
    figure
    for j=1:7
        subplot(7,1,j)
        plot(cmpEMGA.EMG{i}(:,j))
    end
end