function [r,p]=corrAnaly(data1,label1,data2,label2,varargin)
%% reload function
error(nargchk(4,5,nargin));
if nargin ==5 && varargin{1}==1
    Display = 1;
else
    Display = 0;
end

%% calculate corr
N1=length(data1);
N2=length(data2);
[r,p]=corr(data1,data2);
% r1=corrcoef(data1,data2);
% r1=r1(1,2);
%% display
if Display
figure
plot(data1,data2,'*')
for i= 1:length(data1)
    text(data1(i)+var(data1)/1000,data2(i)+var(data2)/1000,num2str(i))
end
hold on
po=polyfit(data1,data2,1);
x1=linspace(min(data1),max(data1));
y1=polyval(po,x1);
plot(data1,data2,'*',x1,y1);
r = eval(vpa(r,2));
p = eval(vpa(p,2));
r1=num2str(r);
p1=num2str(p);
% s1=strcat('N=16','   R=',r1,'   P=',p1);

xlabel(label1);
ylabel(label2);
 %title(['R=' num2str(r1)   'P=' num2str(p1)]);

end