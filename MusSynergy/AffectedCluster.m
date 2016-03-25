close all; clear ; clc;
load('./data/Hma');
load('./data/Hmina');
load('./data/Hn_min');
%load('./data/Hn_4');

display=0;
kind=3;
HRa=[];
HR2a=[];

for i=1:35
    HRa=[HRa;Hma{i}];
    HR2a=[HR2a;Hmina{i}];
end

type=HR2a;

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
T=dendrogram(Z,0);
 x=1:7;
 for i=1:kind
     id=find(cla==i); 
     Ha(i,:)=mean(type(id,:));
     sdata(i,:)=std(type(id,:),1);     
 end
 
 [sim,m,s1]=clusterSim(Hn,Ha);
 [so,ind]=sort(sim,'descend');
 de=m(ind);
 figure
 for i=1:kind
     subplot(1,kind,i);
     barh(Ha(de(i),:))
     hold on
     errorbare('h',Ha(de(i),:),x,sdata(de(i),:),'.k')
     xlim([0 1])
     set(gca,'xticklabel','');
     title(num2str(sim(ind(i))))
     if i==1
     ylabel('Affected Subjects')
     end
 end
 figure
 for i=1:kind    
     subplot(1,kind,i);
     barh(Hn(ind(i),:))
     xlim([0 1])
     
 end