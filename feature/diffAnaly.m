function [Mdata,Sdata,p1]=diffAnaly(dataS,nameS,dataM,nameM,dataU,nameU,label,varargin)
%plot the errorbar of data
%return mean,standard and similarity between affected and mean value

%% reload function
error(nargchk(7,8,nargin));
if nargin ==8 && varargin{1}==1
    Display = 1;
else
    Display = 0;
end

%% calculate the mean value and standard error 
sS=size(dataS);
sM=size(dataM);
sU=size(dataU);
MdataS=mean(dataS);
SdataS=std(dataS,1);
MdataM=mean(dataM);
SdataM=std(dataM,1);
MdataU=mean(dataU);
SdataU=std(dataU,1);
Mdata=[MdataS;MdataM;MdataU];
Sdata=[SdataS;SdataM;SdataU];

    [h,p1]=ttest2(dataS,dataM);
    [h,p2]=ttest2(dataM,dataU);
    [h,p3]=ttest2(dataS,dataU);
    p1 = eval(vpa(p1,2));
    p2 = eval(vpa(p2,2));
    p3 = eval(vpa(p3,2));
    p1=num2str(p1);
    p2=num2str(p2);
    p3=num2str(p3);
%% display bar figure
if Display
    figure
    bar(Mdata,0.5,'c')
    hold on
    errorbar(Mdata,Sdata,'k','LineStyle','none'); 
    set(gca,'XTickLabel',{nameS,nameM,nameU})

    title(['p1=' p1 '   p2=' p2 '   p3=' p3]);
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