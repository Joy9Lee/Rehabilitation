close all; clear; clc;
load('../DATA/SynDataA_35');
load('../DATA/SynDataU_23');
load('maxSAngA')
addpath('G:\SNARC\Rehabilitation\MusSynergy');

disDendrogram=0;
disPareto=0;
for i=1:length(SynDataU.EMGR)            %unaffect people 1:184 each
    SynDataU.EMGR{i}=PreProcess_PCA(SynDataU.EMGR{i});
    SynDataU.EMGL{i}=PreProcess_PCA(SynDataU.EMGL{i});
    % SynDataU.EMGR{i}(1:184,:)=zscore(SynDataU.EMGR{i}(1:184,:));
    EMGU(i,:)=reshape(SynDataU.EMGR{i}(1:184,:),[1,184*7]);
    %EMGU(i,:)=reshape(SynDataU.EMGL{i}(1:197,:),[1,197*7]);
    
end
indi=1:23;
indi([1 3 15 18])=[];
EMGU=EMGU(indi,:);
Avg=mean(EMGU(indi));%平均脸
[coef,score,latent,t2] = pca(EMGU);
percent_explained =cumsum(latent)./sum(latent);            %求出各个主成分的贡献率
if disPareto
    pareto(latent);
end
pca16 = coef(:,1:16);
%pu=(EMGU-ones(23,1)*mean(EMGU))*pca16;         pu=score(:,1:16)
for i=1:length(SynDataA.EMG)-2            %affect
    SynDataA.EMG{i}=PreProcess_PCA(SynDataA.EMG{i});
    EMGA(i,:)=reshape(SynDataA.EMG{i}(1:184,:),[1,184*7]);
    %    EMGA(i,:)=reshape(SynDataA.EMG{i}(1:197,:),[1,197*7]);
    maxSAngA(i)=max(SynDataA.shdAng{i});
    maxEAngA(i)=max(SynDataA.elbAng{i});
    % o(i)=max(SynDataA.elbAng{i});
end
pm=(EMGA-ones(33,1)*mean(EMGU))*pca16;
pmU=(EMGU-ones(19,1)*mean(EMGU))*pca16;

% pm(27,:)=[];
Di = pdist(pm,'minkowski',2);
Z = linkage(Di,'ward');
[c,Dt] = cophenet(Z,Di);
r = corr(Di',Dt','type','spearman');
%Y=inconsistent(Z);
if disDendrogram
    figure
    T=dendrogram(Z,0);
end

% Di = pdist(score(:,1:16),'minkowski',2);
% Z = linkage(Di,'ward');
% [c,Dt] = cophenet(Z,Di);
% r = corr(Di',Dt','type','spearman');
% %Y=inconsistent(Z);
% if disDendrogram
%     figure
%     T=dendrogram(Z,0);
% end
kindA=3;
claold = cluster(Z,'maxclust',kindA);

for i=1:length(claold)
    ind2=find(claold==2);
    ind3=find(claold==3);
end
cla=claold;
cla(ind2)=3;
cla(ind3)=2;
x0=sum(pmU(:,1));
y0=sum(pmU(:,2));
for i=1:max(cla)
    x(i)=sum(pm(find(cla==i),1))./length(find(cla==i));
    y(i)=sum(pm(find(cla==i),2))./length(find(cla==i));
    d(i)=sqrt((x(i)-x0).^2+(y(i)-y0).^2);
end
for i=1:length(pm)
    dist(i)=sqrt((pm(i,1)-x0).^2+(pm(i,2)-y0).^2);
end
% dist([19 32])=[];
% SynDataA.FM([19 32])=[];
[r,p]=corrAnaly(SynDataA.FM(1:33),'Fugl-Meyer Score',dist','Maximum Shoulder Angle/degree',1)
[r2,p2]=corrAnaly(maxSAngA','Fugl-Meyer Score',dist','Maximum Shoulder Angle/degree',1)
figure

plot(pm(find(cla==1),1),pm(find(cla==1),2),'ro')
  text(pm(find(cla==1),1)-0.5,pm(find(cla==1),2)+0.5,num2str(SynDataA.FM(find(cla==1))))
  % text(pm(find(cla==1),1)-0.5,pm(find(cla==1),2)+0.5,num2str(find(cla==1)))
hold on
plot(pm(find(cla==2),1),pm(find(cla==2),2),'b*')
% text(pm(find(cla==2),1),pm(find(cla==2),2)+0.5,num2str(find(cla==2)))
text(pm(find(cla==2),1),pm(find(cla==2),2)+0.5,num2str(SynDataA.FM(find(cla==2))))
hold on

plot(pm(find(cla==3),1),pm(find(cla==3),2),'g+')
text(pm(find(cla==3),1),pm(find(cla==3),2)+0.5,num2str(SynDataA.FM(find(cla==3))))
%text(pm(find(cla==3),1),pm(find(cla==3),2)+0.5,num2str(find(cla==3)))
hold on
for i=1:3
    plot(x(i),y(i),'kx')
    hold on
end
% indi=1:23;
% indi([1 3 15 18])=[];
for i=1:19
    
    plot(pmU(i,1),pmU(i,2),'ms')
    %text(pmU(indi(i),1),pmU(indi(i),2),num2str(i));
    hold on
end
plot(x0,y0,'kx')
legend('class1','class2','class3','Control')
xlabel('CP1')
ylabel('CP2')
ylim([-15 20])

figure
for i=1:length(pm)
    plot(pm(i,1),pm(i,2),'ro')
    hold on
end
for i=1:length(pmU)
    plot(pmU(i,1),pmU(i,2),'ms')
    hold on
end
[Mdata,Sdata,p]=ErrorbarPlot3(maxEAngA,cla);

p=anova1(maxEAngA,cla);
title('maxelbAng')
p2=anova1(maxSAngA,cla);
%title(['P=' num2str(p2)])
ylabel('Maximum Shoulder Angle/degree')
set(gca,'xticklabel',{'class 1','class 2','class 3'});
p3=anova1(SynDataA.FM(1:33),cla);
%title(['P=' num2str(p3)])
ylabel('Fugl-Meyer Score')
set(gca,'xticklabel',{'class 1','class 2','class 3'});
[cidx2,cmeans2,sumd2,D2] = kmeans(pm,3,'dist','sqEuclidean');
P2 = figure;clf;
[silh2,h2] = silhouette(pm,cidx2,'sqeuclidean');
for i=1:kindA
    ind{i}=find(cla==i);
    f{i}=SynDataA.FM(ind{i});
    sang{i}=maxSAngA(ind{i});
    for j=1:length(ind{i})
        ang{i}(j)=max(SynDataA.elbAng{ind{i}(j)});
    end
    mang(i)=mean(ang{i});
end