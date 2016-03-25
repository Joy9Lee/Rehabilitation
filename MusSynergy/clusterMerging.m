close all; clear ; clc;
%% healthy cluster
load('Hm');
load('Hmin');
load('Ha');
display=0;
kind=4;
HR2=[];
for i=1:23
    HR2=[HR2;Hmin{i}];
end

type=HR2;
Di = pdist(type,'minkowski',2);
Z = linkage(Di,'ward');
[c,Dt] = cophenet(Z,Di);
cla = cluster(Z,'maxclust',kind);
r = corr(Di',Dt','type','spearman'); 
figure
H=dendrogram(Z,0);
x=1:7; 
 for i=1:kind
     id=find(cla==i); 
     Hn(i,:)=mean(type(id,:));
     sdata(i,:)=std(type(id,:),1);
 end