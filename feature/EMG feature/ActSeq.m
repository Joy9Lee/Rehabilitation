% The activation sequence
function [acTime,acSeq,X]=ActSeq(EMG)
muscleName={'�ش�';'б����';'���Ǽ�ǰ��';'���Ǽ�����';'�Ŷ�ͷ��';'����ͷ��';'�����'};
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
sprintf('����ʱ��Ϊ');
sprintf('%d ',acTime);
sprintf('The activation sequence is %s %s %s %s %s %s %s',cell2mat(muscleName(acSeq(1))),...
    cell2mat(muscleName(acSeq(2))),cell2mat(muscleName(acSeq(3))),cell2mat(muscleName(acSeq(4))),...
    cell2mat(muscleName(acSeq(5))),cell2mat(muscleName(acSeq(6))),cell2mat(muscleName(acSeq(7))));