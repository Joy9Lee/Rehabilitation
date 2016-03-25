function [sim,m,SimArray]=patternSim(pattern,H,N)

% H1=rand(N,7);
% H2=rand(N,7);
% N=7;
s=size(pattern);
SimArray=zeros(s(1),N);
m=zeros(1,N);
sim=zeros(1,N);
a=1:N;
for i=1:s(1)
    for j=1:N
        SimArray(i,j)=similarity(pattern(i,:),(H(j,:)));
    end
%     sim(i)=max(SimArray(i,a));
%     m(i)=find(SimArray(i,:)==sim(i));
%     a(a==m(i))=[];

end

% [sim(1),m(1)]=max(SimArray(1,:));
% a(a==m(1))=[];
% [sim(2),m(2)]=max(SimArray(2,a));
% a(a==m(2))=[];
% sim(3)=SimArray(2,a);
% m(3)=a;   


