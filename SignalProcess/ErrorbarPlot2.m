function [Mdata,Sdata,p]=ErrorbarPlot2(inDataA,group)
%plot the errorbar of data
%return mean,standard and similarity between affected and mean value
Display = 1;
Grp1=[]; Grp2=[]; Grp3=[]; Grp4=[];
%% group
for i=1:length(group)
    if  max(group)==2
        switch group(i)
            case 1
                Grp1=[Grp1 i];
            case 2
                Grp2=[Grp2 i];
        end
    elseif max(group)==3
        switch group(i)
            case 1
                Grp1=[Grp1 i];
            case 2
                Grp2=[Grp2 i];
            case 3
                Grp3=[Grp3 i];
        end
    elseif max(group)==4
        switch group(i)
            case 1
                Grp1=[Grp1 i];
            case 2
                Grp2=[Grp2 i];
            case 3
                Grp3=[Grp3 i];
            case 4
                Grp4=[Grp4 i];
        end
        
    end
end
%% calculate the mean value and standard error
sA=size(inDataA);
MdataA1=mean(inDataA(Grp1,:));
SdataA1=std(inDataA(Grp1,:),1);
MdataA2=mean(inDataA(Grp2,:));
SdataA2=std(inDataA(Grp2,:),1);
Mdata=[MdataA1;MdataA2]';
Sdata=[SdataA1;SdataA2]';
if max(group)>2
    MdataA3=mean(inDataA(Grp3,:));
    SdataA3=std(inDataA(Grp3,:),1);
    Mdata=[MdataA1;MdataA2;MdataA3]';
    Sdata=[SdataA1;SdataA2;SdataA3]';
    if max(group)>3
        MdataA4=mean(inDataA(Grp4,:));
        SdataA4=std(inDataA(Grp4,:),1);
        Mdata=[MdataA1;MdataA2;MdataA3;MdataA4]';
        Sdata=[SdataA1;SdataA2;SdataA3;SdataA4]';
    end
end
%% display bar figure
if Display
    if sA(2)==1
        figure
        bar(Mdata,0.5,'c')
        hold on
        errorbar(Mdata,Sdata,'k','LineStyle','none');
        set(gca,'XTickLabel',{'Affected','Unaffected'})
       % [h,p]=ttest2(inDataA,inDataU);
    end
    figure
    bar(Mdata,0.5);
    hold on
   % x=[0.85,1.15];
    for i=1:sA(2)
        if max(group)==2
            x(i,:)=[0.85+i-1,1.15+i-1];
            
        elseif max(group)==3
            x(i,:)=[0.78+i-1,i,1.22+i-1];
        elseif max(group)==4
            x(i,:)=[0.73+i-1,0.9+i-1,1.1+i-1,1.27+i-1];
        end
%         [h,p(i)]=ttest2(inDataA(:,i),inDataU(:,i));
[h,p(i)]=ttest2(inDataA(Grp1,i),inDataA(Grp2,i));
        if 0.01<p(i) && p(i)<0.05
            text(i,max(Mdata(i,:))+5,'*');
        elseif p(i)<0.01
            text(i,max(Mdata(i,:))+5,'**');
        end
    end
    errorbar(x,Mdata,Sdata,'k','LineStyle','none');
    set(gca,'XTickLabel',{'胸大肌';'斜方肌';'三角肌前组';'三角肌中组';'肱二头肌';'肱三头肌';'肱桡机'})
%     legend('group1','group2','*p<0.05   ','**p<0.01   ')
% legend('group1','group2','health','*p<0.05   ')
legend('group1','group2','group3','group4')
    ylabel('Strength of Contraction')
    
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