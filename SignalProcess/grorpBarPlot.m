function [p1,p2,Mdata,Sdata]=grorpBarPlot(group4,LABEL,meanA1,meanA2,meanU1,meanU2,ylabel1)
S=size(meanA1);
[~,Grp1,Grp2]=group2(group4,LABEL);
MdataA11=mean(meanA1(Grp1,:));
MdataA12=mean(meanA1(Grp2,:));
MdataA21=mean(meanA2(Grp1,:));
MdataA22=mean(meanA2(Grp2,:));
MdataU1=mean(meanU1);
MdataU2=mean(meanU2);
SdataA11=std(meanA1(Grp1,:),1);
SdataA12=std(meanA1(Grp2,:),1);
SdataA21=std(meanA2(Grp1,:),1);
SdataA22=std(meanA2(Grp2,:),1);
SdataU1=std(meanU1,1);
SdataU2=std(meanU2,1);
Mdata=[MdataA11;MdataA12;MdataA21;MdataA22;MdataU1;MdataU2]';
Sdata=[SdataA11;SdataA12;SdataA21;SdataA22;SdataU1;SdataU2]';
figure
bar(Mdata,0.5);
hold on
if S(2)==7
    for i=1:7
        x(i,:)=[0.67+i-1,0.8+i-1,0.93+i-1,1.07+i-1,1.20+i-1,1.33+i-1];
        [h1,p1(i)]=ttest2(meanA1(Grp1,i),meanA1(Grp2,i));
        [h2,p2(i)]=ttest2(meanA2(Grp1,i),meanA2(Grp2,i));
        if  p1(i)<0.05
            text(0.7+i-1,max(Mdata(i,:))+15,'*');
        end
        if  p2(i)<0.05
            text(i,max(Mdata(i,:))+15,'#');
        end
        
    end
    errorbar(x,Mdata,Sdata,'k','LineStyle','none');
    set(gca,'XTickLabel',{'胸大肌';'斜方肌';'三角肌前组';'三角肌中组';'肱二头肌';'肱三头肌';'肱桡机'})
    legend('Grp1 flx','Grp2 flx','Grp1 hold','Grp2 hold','Health flx','Health hold','*p<0.05 flx','#p<0.05 hold')
elseif S(2)==1
    errorbar(Mdata,Sdata,'k','LineStyle','none');
    set(gca,'XTickLabel',{'Grp1 flx';'Grp2 flx';'Grp1 hold';'Grp2 hold';'Health flx';'Health hold'})
    [h1,p1]=ttest2(meanA1(Grp1,:),meanA1(Grp2,:));
    [h2,p2]=ttest2(meanA2(Grp1,:),meanA2(Grp2,:));
    
end

% ylabel('Strength of Contraction')
ylabel(ylabel1)
