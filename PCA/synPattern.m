close all; clear; clc;
load('../DATA/SynDataA_35');
load('../DATA/SynDataU_23');
addpath('G:\SNARC\Rehabilitation\MusSynergy');
emgU=[];
dispEMG=0;
for i=1:length(SynDataU.EMGR)            %affect
    SynDataU.EMGR{i}=PreProcess(SynDataU.EMGR{i});
    EMGU(i,:)=reshape(SynDataU.EMGR{i}(1:184,:),[1,184*7]);
end
Avg=mean(EMGU);%平均脸
[coef,score,latent,t2] = pca(EMGU);
percent_explained =cumsum(latent)./sum(latent);            %求出各个主成分的贡献率
pareto(latent);
pca16 = coef(:,1:16);
p=EMGU*pca16;
for i=1:length(SynDataA.EMG)-2            %affect
    SynDataA.EMG{i}=PreProcess(SynDataA.EMG{i});
    EMGA(i,:)=reshape(SynDataA.EMG{i}(1:184,:),[1,184*7]);
end
pm=EMGA*pca16;
Di = pdist(pm,'minkowski',2);
s= squareform(Di);
kindA=4;
Z = linkage(Di,'ward');
[c,Dt] = cophenet(Z,Di);
inconsistent(Z);
figure
T=dendrogram(Z,0);
cla = cluster(Z,'maxclust',kindA);
Du = pdist(score(:,1:16),'minkowski',2);
s= squareform(Du);
kindU=3;
Z = linkage(Du,'ward');
[c1,Dt1] = cophenet(Z,Du);
inconsistent(Z);
clu = cluster(Z,'maxclust',kindU);
figure
T=dendrogram(Z,0);
for i=1:kindA
    f{i}=SynDataA.FM(find(cla==i));
    ind{i}=find(cla==i);
    for j=1:length(ind{i})
       ang{i}(j)=max(SynDataA.elbAng{ind{i}(j)});
       % ang{i}(j)=max(SynDataU.shdAngR{ind{i}(j)});
    end
    mang(i)=mean(ang{i});
    
   %  f{i}=(find(cla==i));
%     mang=mean(ang{i}) ;
end
for i=1:length(SynDataA.EMG)-2            %affect
    %
end