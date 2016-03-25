clc;clear;
index=4;
n=1;
DataA(n).L.emgLen=[1 2 3];
len=[index(1);diff(index)];
k=1;
for kl=1:length(index)
    for el=1:length(DataA(n).L.emgLen)
        dl{k}(kl,el)=abs(len(kl)*20-DataA(n).L.emgLen(el));
    end
end