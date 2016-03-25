function [Mdata,Sdata,p1,p2]=group2BarPlot(group4,LABEL,meanA1,meanH)
S=size(meanA1);
[~,Grp1,Grp2]=group2(group4,LABEL);
MdataA11=mean(meanA1(Grp1));
MdataA12=mean(meanA1(Grp2));
MdataH=mean(meanH);
SdataA11=std(meanA1(Grp1),1);
SdataA12=std(meanA1(Grp1),1);
SdataU1=std(meanH,1);

Mdata=[MdataA11;MdataA12;MdataH]';
Sdata=[SdataA11;SdataA12;SdataU1]';
figure
bar(Mdata,0.5);
hold on

         x=[1,2,3];
        [h1,p1]=ttest2(meanA1(Grp1),meanA1(Grp2));
        [h2,p2]=ttest2(meanA1,meanH);
%         if  p1(i)<0.05
%             text(0.7,max(Mdata)+15,'*');
%         end
                
   
    errorbar(x,Mdata,Sdata,'k','LineStyle','none');
    set(gca,'XTickLabel',{'胸大肌';'斜方肌';'三角肌前组';'三角肌中组';'肱二头肌';'肱三头肌';'肱桡机'})
    %legend('Grp1 ','Grp2 ','Health ','*p<0.05 flx')



% ylabel('Strength of Contraction')
ylabel('similarity ')
