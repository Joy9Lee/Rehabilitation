close all;clear ;clc
load('../../SynDataA_39');
% load('../../SynDataU_25');
newname={'王京波2','裴京平','张为公','张辉','刘建华','王晓媛','倪醒钟','倪醒钟2','王晓华','倪醒钟3','刘建华2','朱玉江','王晓媛2','王晓华2','郝保建','樊菊英','王素玲','徐志安','邓立东'};
for i=1:length(SynDataA.name)
   
    indA{i}=find(strcmp(newname,SynDataA.name{i}'));
    
  

end
indA=indA';
t=1:19;
for i=1:length(SynDataA.name)
    ind(i)=ismember(indA{i},t);
end