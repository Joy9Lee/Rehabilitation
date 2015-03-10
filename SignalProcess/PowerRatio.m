function PwRatio=PowerRatio(data)
%calculate the ratio of power of each muscle to the whole
%input data is a struct

%% Initial variables
N=length(data);

%% PowerRatio function
for i=1:N
    inData=data{i};
    s=size(inData);
    AllPower(i,:)=sum(sum(abs(inData)));
    for j=1:s(2)
        PwRatio(i,j)= sum(inData(:,j))./ AllPower(i,:);
       
    end  
end
end