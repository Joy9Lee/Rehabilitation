% read data
clear 
close all
clc
Path = 'G:\SNARC\DATA\';
%Path = 'F:\SNARC-work\¿µ¸´\DATA\';
oriPath=[Path '»¼Õß×é'];
[fmXls,nameXls] = xlsread([Path 'profile.xlsx']);
%[fmXls,nameXls] = xlsread('F:\SNARC-work\¿µ¸´\DATA\profile.xlsx');
nameList = dir(fullfile(oriPath));
EMGFLAG = 1;
for s = 1:length(nameList)-2
    DataA(s).name={};
    DataA(s).FM=NaN;
    DataA(s).affSide={};
    DataA(s).R.flx.kin=[];
    DataA(s).R.abd.kin=[];
    DataA(s).L.flx.kin=[];
    DataA(s).L.abd.kin=[];
    DataA(s).R.flx.sEMG={};
    DataA(s).R.abd.sEMG={};
    DataA(s).L.flx.sEMG={};
    DataA(s).L.abd.sEMG={};
    DataA(s).R.flx.mvc={};
    DataA(s).R.abd.mvc={};
    DataA(s).L.flx.mvc={};
    DataA(s).L.abd.mvc={};

end
for n = 1:length(nameList)-2          %traverse each person
    DataA(n).name=nameList(n+2).name;
    
    index = ismember(nameXls,DataA(n).name);
    DataA(n).FM = fmXls(index);
    
    sideList=dir(fullfile(oriPath,nameList(n+2).name));
end
