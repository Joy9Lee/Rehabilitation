close all; clear ; clc;
load('../DATA/SynDataA_35');
load('../DATA/SynDataU_23');
load('./data/Na');
addpath('../SignalProcess');
addpath('../feature')
HRa=[];
HR2a=[];
display=0;
for i=1:length(SynDataA.name)
    Hma{i}=0;
end
for i=1:length(SynDataA.name)
    SynDataA.EMG{i}=PreProcess(SynDataA.EMG{i});
    N=Na(i);
    SynDataA.EMGU{i}=PreProcess(SynDataA.EMGU{i});
    
   
    for k=1:50
    [W{i,k},H{i,k},R(i,k),D(i,k)]=ExtractSynergy(SynDataA.EMG{i},N,1000,5);
    
    [W2{i,k},H2{i,k},R2(i,k),D2(i,k)]=ExtractSynergy(SynDataA.EMGU{i},N,1000,5);
   
    Hma{i}=Hma{i}+H{i,k};
    end  
    [m,ind]=min(R(i,:));
    Hma{i}=Hma{i}./k;
    Hmina{i}=H{i,ind};
    HRa=[HRa;Hma{i}];
    HR2a=[HR2a;Hmina{i}];
end
if display
 for l=1:9
    for i=1:9
        figure(l)
        subplot(12,8,i);
        barh(HRa(i+(l-1)*9,:));
    end
 end 
end
  figure
        subplot(12,8,1);
        bar(HRa(1,:));
Di = pdist(HRa,'minkowski',2);
s= squareform(Di);

Z = linkage(Di,'ward');
[c,Dt] = cophenet(Z,Di);
inconsistent(Z)
cla = cluster(Z,'maxclust',9);
r = corr(Di',Dt','type','spearman'); 
 T=dendrogram(Z,0);
%c = cluster(Z,'maxclust',3:5);
%scatter3(HR(:,1),HR(:,2),HR(:,3),10,c)