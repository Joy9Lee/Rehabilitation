close all; clear; clc;
load('../DATA/SynDataA_39');
load('../DATA/SynDataU_23');
addpath('G:\SNARC\Rehabilitation\MusSynergy');

disDendrogram=1;
for i=1:length(SynDataU.EMGR)            %unaffect people 1:184 each
    SynDataU.EMGR{i}=PreProcess(SynDataU.EMGR{i});
    EMGU(i,:)=reshape(SynDataU.EMGR{i}(1:184,:),[1,184*7]);
end
Avg=mean(EMGU);%平均脸
[coef,score,latent,t2] = pca(EMGU);
percent_explained =cumsum(latent)./sum(latent);            %求出各个主成分的贡献率
%pareto(latent);
pca16 = coef(:,1:16);
%pu=(EMGU-ones(23,1)*mean(EMGU))*pca16;         pu=score(:,1:16)
for i=1:length(SynDataA.EMG)-2            %affect
    SynDataA.EMG{i}=PreProcess(SynDataA.EMG{i});
    EMGA(i,:)=reshape(SynDataA.EMG{i}(1:184,:),[1,184*7]);
    maxSAngA(i)=max(SynDataA.shdAng{i});
    maxEAngA(i)=max(SynDataA.elbAng{i});
   % o(i)=max(SynDataA.elbAng{i});
end
% pm=(EMGA-ones(37,1)*mean(EMGU))*pca16;
pm=EMGA*pca16;
Di = pdist(pm,'minkowski',2);
Z = linkage(Di,'ward');
[c,Dt] = cophenet(Z,Di);
r = corr(Di',Dt','type','spearman');
%Y=inconsistent(Z);
if disDendrogram
    figure
    T=dendrogram(Z,0);
end
kindA=3;
cla = cluster(Z,'maxclust',kindA);
cla(27)=[];
SynDataA.FM(27)=[]; 
maxEAngA(27)=[];
maxSAngA(27)=[];
p=anova1(maxEAngA,cla);
title('maxelbAng')
p2=anova1(maxSAngA,cla);
title('maxshdAng')
p3=anova1(SynDataA.FM(1:36),cla);
title('FM')
%p=anova1(maxSAngA,cla);
[Mdata,Sdata,p]=ErrorbarPlot3(SynDataA.FM,cla);
%[Mdata,Sdata]=ErrorbarPlot3(maxSAngA,cla);

title('maxAng')

%p2=anova1(SynDataA.FM(1:37),cla);
title('FM')
for i=1:kindA
    ind{i}=find(cla==i);
    f{i}=SynDataA.FM(ind{i});
    
    for j=1:length(ind{i})
       ang{i}(j)=max(SynDataA.elbAng{ind{i}(j)});
    end
    mang(i)=mean(ang{i});
end