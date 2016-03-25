close all;clear ;clc
load('../DATA/SynDataA_39');
load('../DATA/SynDataU_25');
load('../DATA/locA');
load('../DATA/locH');
addpath('../SignalProcess')
for i=1:37
    SynDataA.EMG{i}=PreProcess(SynDataA.EMG{i});
    %iEMGA{i}=winRMS(SynDataA.EMG{i},20);
    EMGA{i}=SynDataA.EMG{i};
    %EMGA{i}=iEMGA{i}(1:200,:);
    [coeff{i},score{i},latent{i}]=pca(EMGA{i});
    conRate{i}=cumsum(latent{i})./sum(latent{i});   
   
    if 1
        figure(1)
        subplot(5,8,i)
        plot(EMGA{i})
         figure
    bar(coeff{i})
    title(['Grp=',num2str(SynDataA.group(i))])
        
    end
end