function [sim,m,SimArray]=synergySim(H1,H2,N)
% N=3;
% H1=rand(N,7);
% H2=rand(N,7);

SimArray=zeros(N,N);
m=zeros(1,N);
sim=zeros(1,N);
a=1:N;
for i=1:N
    for j=1:N
        SimArray(i,j)=similarity(H1(i,:),(H2(j,:)));
    end
    sim(i)=max(SimArray(i,a));
    m(i)=find(SimArray(i,:)==sim(i));
    a(a==m(i))=[];

end

% [sim(1),m(1)]=max(SimArray(1,:));
% a(a==m(1))=[];
% [sim(2),m(2)]=max(SimArray(2,a));
% a(a==m(2))=[];
% sim(3)=SimArray(2,a);
% m(3)=a;   


