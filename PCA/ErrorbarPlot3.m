function [Mdata,Sdata,p]=ErrorbarPlot3(inDataA,group)
cla=max(group);
for i=1:cla
    Mdata(i)=mean(inDataA(group==i));
    Sdata(i)=std(inDataA(group==i),1);
end
[h(1),p(1)]=ttest2(inDataA(group==1),inDataA(group==2));
[h(2),p(2)]=ttest2(inDataA(group==1),inDataA(group==3));
[h(3),p(3)]=ttest2(inDataA(group==2),inDataA(group==3));
