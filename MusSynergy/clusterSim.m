function [sim,m,SimArray]=clusterSim(cluster1,cluster2)
% close all; clear ; clc;
% cluster1=rand(9,7);
% cluster2=rand(9,7);
 
s1=size(cluster1);
s2=size(cluster2);
N=s1(1);
SimArray=zeros(s1(1),s2(1));
m=zeros(1,N);
sim=zeros(1,N);
a=1:s2(1);
for i=1:s1(1)
    for j=1:s2(1)
        SimArray(i,j)=similarity(cluster1(i,:),(cluster2(j,:)));
    end
    sim(i)=max(SimArray(i,a));
    m(i)=find(SimArray(i,:)==sim(i));
    a(a==m(i))=[];

end

sim=sim';
m=m';
% [sim(1),m(1)]=max(SimArray(1,:));
% a(a==m(1))=[];
% [sim(2),m(2)]=max(SimArray(2,a));
% a(a==m(2))=[];
% sim(3)=SimArray(2,a);
% m(3)=a;   


