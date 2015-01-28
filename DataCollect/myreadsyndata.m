%read data from excel
clear all
close all
clc

synDataA=struct('name',{},'FM',{},'ang',{struct('shd',{},'elb',{},'wrt',{})},'sEMG',{});
synDataU=struct('name',{},'ang',{struct('shd',{},'elb',{},'wrt',{})},'sEMG',{});
% shd=struct('adb',{},'flx',{},'rot',{});
% elb=struct('adb',{},'flx',{},'rot',{});
% wrt=struct('adb',{},'flx',{},'rot',{});

[num,txt,raw]=xlsread('肌电运动数据.xlsx','患者原始数据');
s=size(raw);
len=8;          %excel中每个人数据列数
for i=1:(s(2)+1)/len
    synDataA(i).name=txt(1,(i-1)*8+2);
    synDataA(i).FM=num(1,(i-1)*8+2);
    
    temp = num(3:end,(i-1)*8+1);
    temp = temp(~isnan(temp));
    synDataA(i).ang.shd.adb=temp;
    
    temp = num(3:end,(i-1)*8+2);
    temp = temp(~isnan(temp));
    synDataA(i).ang.elb.adb=temp;
    
    temp = num(3:end,(i-1)*8+3:(i-1)*8+6);
    temp(any(isnan(temp)'),:) = [];
    synDataA(i).sEMG=temp;
    
end

[num,txt,raw]=xlsread('肌电运动数据.xlsx','正常人原始数据');
s=size(raw);
len=8;          %excel中每个人数据列数
for i=1:(s(2)+1)/len
    synDataU(i).name=txt(1,(i-1)*8+2);
%    synData(i).FM=num(1,(i-1)*8+2);
    
    temp = num(3:end,(i-1)*8+1);
    temp = temp(~isnan(temp));
    synDataU(i).ang.shd.adb=temp;
    
    temp = num(3:end,(i-1)*8+2);
    temp = temp(~isnan(temp));
    synDataU(i).ang.elb.adb=temp;
    
    temp = num(3:end,(i-1)*8+3:(i-1)*8+6);
    temp(any(isnan(temp)'),:) = [];
    synDataU(i).sEMG=temp;
    
end
