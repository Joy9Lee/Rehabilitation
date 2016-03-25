function Sim1=synAnalysis(data1,data2,N,varargin)
%Compute similatiry of two sEMG
%   Sim1=synAnalysis(data1,data2,N)
%   Sim1=synAnalysis(data1,data2,N,'d')
%   data is the origin sEMG signal and N is the number of muscle
%   varargin is the reloading argument.
%   Add argument 'd' to display the figure.

%% reloading function
error(nargchk(3,4,nargin));
if nargin ==4 && varargin{1}=='d'
    Display = 1;
else
    Display = 0;
end

%data1=abs(data1);
data1=SigPre(data1);
[H1,R1]=EMS(data1,N);
%data2=abs(data2);
data2=SigPre(data2);
[H2,R2]=EMS(data2,N,'d');

%data=datablock1.data;
%dlmread('wnn-motionL1-1.ASC','%d',']')
%data=load('djl-R1.txt');

SimArray=zeros(N,N);
for i= 1:N
    for j=1:N
        SimArray(i,j)=similarity(H1(i,:),(H2(j,:)));
    end
end

Sim=zeros(N,1);
H3 = zeros(N,7);
for i=1:N
   [Sim(i),I]=max(SimArray(:));
   [m,n]=ind2sub(size(SimArray),I);
   H3(i,:)=H1(m,:);
   H4(i,:)=H2(n,:);
   SimArray(m,:)=0;
   SimArray(:,n)=0;
end

clear H1 H2;
if Display == 1
    figure
    for i=1:N
        subplot(2,N,i);
        bar(H3(i,:));     
        title(Sim(i));
    end
    for i=1:N
        subplot(2,N,i+N);
        bar(H4(i,:));
    end
end
Sim1=sum(Sim)/N;