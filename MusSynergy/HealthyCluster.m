close all; clear ; clc;
load('./data/Hm');
load('./data/Hmin');
load('./data/Ha');
display=0;
kind=9;
HR=[];
HR2=[];

for i=1:23
    HR=[HR;Hm{i}];
    HR2=[HR2;Hmin{i}];
end

type=HR2;

if display
    for l=1:9
        for i=1:9
            figure(l)
            subplot(3,3,i);
            barh(type(i+(l-1)*9,:));
        end
    end
end

Di = pdist(type,'minkowski',2);
s= squareform(Di);

Z = linkage(Di,'ward');
[c,Dt] = cophenet(Z,Di);
inconsistent(Z);
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
[sim,m,s1]=clusterSim(Hn,Ha);
[so,ind]=sort(sim,'descend');
figure
for i=1:kind
    subplot(1,kind,i);
    barh(Hn(ind(i),:))
    hold on
    errorbare('h',Hn(ind(i),:),x,sdata(ind(i),:),'.k')
    set(gca,'xticklabel','');
    xlim([0 1])
    if i==1
        ylabel('Healthy Subjects')
    end
end