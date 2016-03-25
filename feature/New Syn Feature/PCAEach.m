close all;clear ;clc
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
load('../../DATA/locA');
load('../../DATA/locH');
addpath('../../SignalProcess')
for i=1:37
    SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
    iEMGA{i}=winRMS(SynDataA.EMG{i},20);
    EMGA{i}=iEMGA{i};
    %EMGA{i}=iEMGA{i}(1:200,:);
    [coeff{i},score{i},latent{i}]=pca(EMGA{i});
    conRate{i}=cumsum(latent{i})./sum(latent{i});   
   
    if 0
         figure
    bar(coeff{i}')
        figure(1)
        subplot(5,8,i)
        plot(EMGA{i})
    end
end