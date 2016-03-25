%reconsitution the DATA struct 
%put index position at last
clear;
addpath('../DATA');
load('synDataA');
load('synDataU');
for i=1:length(synDataA)
    DataA.name(i)=synDataA(i).name;
    DataA.FM(i)=synDataA(i).FM;
    DataA.shd{i}=synDataA(i).ang.shd.adb;
    DataA.elb{i}=synDataA(i).ang.elb.adb;
    DataA.sEMG(i)={synDataA(i).sEMG};
    DataA.loc(i)=synDataA(i).loc;
end

for i=1:length(synDataU)
    DataU.name(i)=synDataU(i).name;
    DataU.shd{i}=synDataU(i).ang.shd.adb;
    DataU.elb{i}=synDataU(i).ang.elb.adb;
    DataU.sEMG(i)={synDataU(i).sEMG};
    DataU.loc(i)=synDataU(i).loc;
end