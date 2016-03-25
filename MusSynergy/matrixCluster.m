%生成随机数据
clear;clc;
a=10*(1:2:9);
b=[0,sort(randint(1,4,[1,199])),200];
idx=randperm(200);
for n=1:5
X(idx((b(n)+1):b(n+1)),:)=unifrnd(a(n),a(n)+10,b(n+1)-b(n),3);
end
%聚类
Z=clusterdata(X,'maxclust',5);
%绘图
for n=1:5
Y(n,:)=mean(X(Z==n,:));
end
scatter3(X(:,1),X(:,2),X(:,3),10,Z);
hold on;
plot3(Y(:,1),Y(:,2),Y(:,3),'rp','markerfacecolor','r','markersize',10)