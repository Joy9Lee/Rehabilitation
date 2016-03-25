function [Mdata,Sdata,p]=ErrorbarPlot5(data1,name1,data2,name2,data3,name3,data4,name4,dataU,nameU,ylableName,varargin)
%plot the errorbar of data
%return mean,standard and similarity between affected and mean value

%% reload function
error(nargchk(11,12,nargin));
if nargin ==12 && varargin{1}==1
    Display = 1;
else
    Display = 0;
end
p=0;
%% calculate the mean value and standard error 
sA=size(data1);
sU=size(dataU);
MdataA1=mean(data1);
MdataA2=mean(data2);
MdataA3=mean(data3);
MdataA4=mean(data4);
MdataU=mean(dataU);
SdataA1=std(data1,1);
SdataA2=std(data2,1);
SdataA3=std(data3,1);
SdataA4=std(data4,1);
SdataU=std(dataU,1);
Mdata=[MdataA1;MdataA2;MdataA3;MdataA4;MdataU]';
Sdata=[SdataA1;SdataA2;SdataA3;SdataA4;SdataU]';

%% display bar figure
if Display
    if sA(2)==1
        figure
        bar(Mdata,0.5,'c')
        hold on
        errorbar(Mdata,Sdata,'k','LineStyle','none'); 
        set(gca,'XTickLabel',{'Affected','Unaffected'})
        [h,p]=ttest2(data1,dataU);
    end
    figure
    bar(Mdata,0.5);  
    hold on

%     for i=1:sA(2)
%         x(i,:)=[0.73+i-1,0.9+i-1,1,1.1+i-1,1.27+i-1];
%         [h,p(i)]=ttest2(inDataA(:,i),inDataU(:,i));
%         %if h==1
%         if p(i)<0.05
%         text(i,max(Mdata(i,:))+0.3,'*');
%         end
%     end
     errorbar(Mdata,Sdata,'k','LineStyle','none');  
     set(gca,'XTickLabel',{name1;name2;name3;name4;nameU})
%    set(gca,'XTickLabel',{'胸大肌';'斜方肌';'三角肌前组';'三角肌中组';'肱二头肌';'肱三头肌';'肱桡机'})
    %ylabel('Power Ratio')
    ylabel(ylableName)
%    legend(name1,name2,name3,name4,nameU)
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