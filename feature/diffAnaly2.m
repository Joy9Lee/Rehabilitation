function [Mdata,Sdata,p1]=diffAnaly(dataA,nameA,dataU,nameU,label,varargin)
%plot the errorbar of data
%return mean,standard and similarity between affected and mean value

%% reload function
error(nargchk(5,6,nargin));
if nargin ==6 && varargin{1}==1
    Display = 1;
else
    Display = 0;
end

%% calculate the mean value and standard error 
sA=size(dataA);
sU=size(dataU);
MdataA=mean(dataA);
SdataA=std(dataA,1);
MdataU=mean(dataU);
SdataU=std(dataU,1);
Mdata=[MdataA;MdataU];
Sdata=[SdataA;SdataU];
%% display bar figure
if Display
    figure
    bar(Mdata,0.5,'c')
    hold on
    errorbar(Mdata,Sdata,'k','LineStyle','none'); 
    set(gca,'XTickLabel',{nameA,nameU})
    [h,p1]=ttest2(dataA,dataU);
    p1 = eval(vpa(p1,2));
    p1=num2str(p1);
    title(['P=' p1]);
    ylabel(label);
end
end


%{

p=zeros(1,4);
for i=1:4
   
    %[r,p1(i)]=corr(x4',y');
    
    if p(i)<0.05
        text(i,max(MdataT(i,1:2))+0.1,'*');
    end
    
end
legend('Affected','Unaffected','*p<0.05    ')

subplot(2,2,1)
bar(Mdata(1,:),'grouped','c');  
set(gca,'XTickLabel',{'斜方肌','三角肌前组','肱二头肌','肱三头肌'})
hold on;  
errorbar(Mdata(1,:),Vdata(1,:),'k','LineStyle','none');  
title('Affected isometric ')
ylabel('Power Ratio')
%}