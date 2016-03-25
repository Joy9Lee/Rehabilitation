close all; clear ; clc;
load('../DATA/SynDataA_35');
load('../DATA/SynDataU_23');
load('./data/Nr');
addpath('../SignalProcess');
addpath('../feature')
HR=[];
HR2=[];
display=0;
for i=1:length(SynDataU.name)
    Hm{i}=0;
end
for i=1:length(SynDataU.name)
    SynDataU.EMGR{i}=PreProcess(SynDataU.EMGR{i});
    N=Nr(i);
    SynDataU.EMGL{i}=PreProcess(SynDataU.EMGL{i});
    
   
    for k=1:50
    [W{i,k},H{i,k},R(i,k),D(i,k)]=ExtractSynergy(SynDataU.EMGR{i},N,1000,5);
    
    [W2{i,k},H2{i,k},R2(i,k),D2(i,k)]=ExtractSynergy(SynDataU.EMGL{i},N,1000,5);
   
    Hm{i}=Hm{i}+H{i,k};
    end  
    [m,ind]=min(R(i,:));
    Hm{i}=Hm{i}./k;
    Hmin{i}=H{i,ind};
    figure
    subplot(3,3,i);
    barh(HR(i+(l-1)*9,:));
    HR=[HR;Hm{i}];
    HR2=[HR2;Hmin{i}];
end
if display
 for l=1:9
    for i=1:9
        figure(l)
        subplot(3,3,i);
        barh(HR(i+(l-1)*9,:));
    end
 end 
end
Di = pdist(HR,'minkowski',2);
s= squareform(Di);

Z = linkage(Di,'ward');
[c,Dt] = cophenet(Z,Di);
inconsistent(Z)
cla = cluster(Z,'maxclust',9);
r = corr(Di',Dt','type','spearman'); 
 H=dendrogram(Z,0);
%c = cluster(Z,'maxclust',3:5);
%scatter3(HR(:,1),HR(:,2),HR(:,3),10,c)