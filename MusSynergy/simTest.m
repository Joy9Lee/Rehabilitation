%function [sim,m,SimArray]=clusterSim(cluster1,cluster2)
close all; clear ; clc;
cluster1=rand(9,7);
cluster2=rand(9,7);
 
s1=size(cluster1);
s2=size(cluster2);
N=s1(2);
SimArray=zeros(s1(1),s2(1));
ind=zeros(1,N);
sim=zeros(1,N);
m=1:s2(1);
n=1:s1(1);
a=1:s2(1);
for i=1:s1(1)
    for j=1:s2(1)
        SimArray(i,j)=similarity(cluster1(i,:),(cluster2(j,:)));
    end
     sim2(i)=max(SimArray(i,a));
    m2(i)=find(SimArray(i,:)==sim2(i));
    a(a==m2(i))=[];
end
for i=1:s1(1)
    
        sim(i)=max(max(SimArray(m,n)));
        [x,y]=find(SimArray==sim(i));
        m(m==x)=[];
        n(n==y)=[];
    
end

sim=sim';
sim2=sim2';
ind=ind';
% [sim(1),m(1)]=max(SimArray(1,:));
% a(a==m(1))=[];
% [sim(2),m(2)]=max(SimArray(2,a));
% a(a==m(2))=[];
% sim(3)=SimArray(2,a);
% m(3)=a;   


