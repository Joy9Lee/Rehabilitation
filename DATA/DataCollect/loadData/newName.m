close all;clear ;clc
load('../../SynDataA_39');
% load('../../SynDataU_25');
newname={'������2','�ᾩƽ','��Ϊ��','�Ż�','������','������','������','������2','������','������3','������2','����','������2','������2','�±���','����Ӣ','������','��־��','������'};
for i=1:length(SynDataA.name)
   
    indA{i}=find(strcmp(newname,SynDataA.name{i}'));
    
  

end
indA=indA';
t=1:19;
for i=1:length(SynDataA.name)
    ind(i)=ismember(indA{i},t);
end