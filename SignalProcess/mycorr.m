function [r,p]=mycorr(data1,data2,pointText,varargin)
%% reload function
error(nargchk(3,4,nargin));
if nargin==4 && varargin{1}==1
    Display = 1;
else
    Display = 0;
end

%% calculate corr
N1=length(data1);
N2=length(data2);
[r,p]=corr(data1',data2');
r1=corrcoef(data1,data2);
r1=r1(1,2);
%% display
if Display
figure
plot(data1,data2,'*')
if pointText~=0
    for i= 1:length(data1)
        text(data1(i)+var(data1)/1000,data2(i)+var(data2)/1000,num2str(pointText(i)));
    end
end
hold on
po=polyfit(data1,data2,1);
x1=linspace(min(data1),max(data1));
y1=polyval(po,x1);
plot(data1,data2,'*',x1,y1);
r1=num2str(r1');
p1=num2str(p');
N1=num2str(N1');
s1=strcat('N=',N1,'   R=',r1,'   P=',p1);

xlabel('Fugl-Meyer Score');
ylabel('募集模式相似度');
title(s1);

end
end