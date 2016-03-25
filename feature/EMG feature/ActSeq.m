% The activation sequence
function [acTime,acSeq,X]=ActSeq(EMG)
muscleName={'胸大肌';'斜方肌';'三角肌前组';'三角肌中组';'肱二头肌';'肱三头肌';'肱桡机'};
%MaxiEMG=max(iEMG,[],1);       %calculate the max value
 
for i=1:7
    s(i)=sum(abs(EMG(1:20,i)))/20;
    threshold(i)=s(i)*3;       %Threshold setting
    if isempty(find(abs(EMG(:,i))>threshold(i),1))
         X(i) = inf;
     else
         X(i)=find(abs(EMG(:,i))>threshold(i),1);
     end
   
end
[acTime,acSeq]=sort(X);
sprintf('激活时间为');
sprintf('%d ',acTime);
sprintf('The activation sequence is %s %s %s %s %s %s %s',cell2mat(muscleName(acSeq(1))),...
    cell2mat(muscleName(acSeq(2))),cell2mat(muscleName(acSeq(3))),cell2mat(muscleName(acSeq(4))),...
    cell2mat(muscleName(acSeq(5))),cell2mat(muscleName(acSeq(6))),cell2mat(muscleName(acSeq(7))));