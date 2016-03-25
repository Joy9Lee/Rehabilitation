close all; clear ; clc;
load('../DATA/SynDataA_35');
load('../DATA/SynDataU_23');
addpath('../SignalProcess');
addpath('../feature')
N=3;
for i=1:length(SynDataA.name)
    figure
    for j=1:7
        subplot(7,1,j)
        plot(SynDataA.EMG{i}(:,j))
    end
    suptitle('raw EMG')
    SynDataA.EMG{i}=PreProcess(SynDataA.EMG{i});
    figure
    for j=1:7
        subplot(7,1,j)
        plot(SynDataA.EMG{i}(:,j))
    end
    suptitle('Preprocessed EMG')
    [W{i},H{i},R(i),D(i)]=ExtractSynergy(SynDataA.EMG{i},N,1000,5,1);
    
    M{i}=W{i}*H{i};
    figure
     for j=1:7
        subplot(7,1,j)
        plot(M{i}(:,j))
    end
    suptitle('Reconstruction EMG')
    SynDataA.EMGU{i}=PreProcess(SynDataA.EMGU{i});
    [H2,W2,R2(i),D2(i)]=ExtractSynergy(SynDataA.EMGU{i},N,20,5,1);
end