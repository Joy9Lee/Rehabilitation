close all;clear ;clc
load('../../DATA/SynDataA_39');
addpath('../../SignalProcess')
i=5;
SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
EMGA{i}=winRMS(SynDataA.EMG{i},20);
EMGA{i}=zscore(EMGA{i},1);
[coeff,score,latent]=pca(EMGA{i});
y=EMGA{i}*coeff;
a=[-1 -1 0 2 0;-2 0 0 1 1];
[coeff2,score2,latent2]=pca(a);
x=rand(10,8);
z=zscore(x);
[coeff1,score1,latent1]=pca(z);
u=z(3,:)*coeff1(:,1)