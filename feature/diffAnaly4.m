function [Mdata,Sdata,p]=diffAnaly4(data1,name1,data2,name2,data3,name3,data4,name4,dataU,nameU,label,varargin)
%plot the errorbar of data
%return mean,standard and similarity between affected and mean value

%% reload function
error(nargchk(11,12,nargin));
if nargin ==12 && varargin{1}==1
    Display = 1;
else
    Display = 0;
end

%% calculate the mean value and standard error
s1=size(data1);
sM=size(data2);
sU=size(dataU);
Mdata1=mean(data1);
Sdata1=std(data1,1);
Mdata2=mean(data2);
Sdata2=std(data2,1);
Mdata3=mean(data3);
Sdata3=std(data3,1);
Mdata4=mean(data4);
Sdata4=std(data4,1);
MdataU=mean(dataU);
SdataU=std(dataU,1);
Mdata=[Mdata1;Mdata2;Mdata3;Mdata4;MdataU];
Sdata=[Sdata1;Sdata2;Sdata3;Sdata4;SdataU];

[h,p(1)]=ttest2(data1,data2);
[h,p(2)]=ttest2(data1,data3);
[h,p(3)]=ttest2(data1,data4);
[h,p(4)]=ttest2(data2,data3);
[h,p(5)]=ttest2(data2,data4);
[h,p(6)]=ttest2(data3,data4);
[h,p(7)]=ttest2(data1,dataU);
[h,p(8)]=ttest2(data2,dataU);
[h,p(9)]=ttest2(data3,dataU);
[h,p(10)]=ttest2(data4,dataU);
for i=1:10
    p(i)=eval(vpa(p(i),2));  %set Variable-precision
end
for j=1:10
    ps{j}=num2str(p(j));
end

%% display bar figure
if Display
    figure
    bar(Mdata,0.5,'c')
    hold on
    errorbar(Mdata,Sdata,'k','LineStyle','none');
    set(gca,'XTickLabel',{name1,name2,name3,name4,nameU})
    
    %title(['p1=' ps{1}  'p2=' ps{2} 'p3=' ps{3} 'p4=' ps{4} 'p5=' ps{5} 'p6=' ps{6}  'p7=' ps{7}  'p8=' ps{8}  'p9=' ps{9} 'p10=' ps{10} ]);
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