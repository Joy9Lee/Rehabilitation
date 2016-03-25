close all; clear; clc;
load('../DATA/cmpEMGA');
load('../DATA/cmpEMGH');
addpath('G:\SNARC\Rehabilitation\feature');
addpath('G:\SNARC\Rehabilitation\SignalProcess');
N=1;
NA=5;
NH=3;
display=0;
cla='h';

for i=1:length(cmpEMGA.name)            %affect
    
    cmpEMGA.EMG{i}=PreProcess(cmpEMGA.EMG{i},1);
    cmpEMGA.EMGU{i}=PreProcess(cmpEMGA.EMGU{i});
   
    [H{i},W{i},R(i),D(i)]=ExtractSynergy(cmpEMGA.EMG{i}',NA,1000,5);
    
    [H2{i},W2{i},R2(i),D2(i)]=ExtractSynergy(cmpEMGA.EMGU{i}',NA,1000,5);
    figure
    for j=1:NA
        subplot(NA,1,j)
        plot(H{i}(j,:));
    end

    figure
    for j=1:NA
        subplot(1,NA,j);
        barh(W{i}(:,j));
    end
end;