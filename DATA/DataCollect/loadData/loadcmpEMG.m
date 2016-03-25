close all; clear; clc;
addpath('G:\SNARC\Rehabilitation\MusSynergy');
addpath('G:\SNARC\Rehabilitation\feature');
addpath('G:\SNARC\Rehabilitation\SignalProcess');
Path = 'G:\SNARC\DATA\';
Apath='affected side';
Upath='unaffected side';
Rpath='HealthR';
Lpath='HealthL';

[fmXls,nameXls] = xlsread([Path 'cmpInfo.xlsx']);
cmpEMGA.name=[];
cmpEMGA.FM=[];
cmpEMGA.group=[];
nameListA = dir(fullfile([Path Apath]));
nameListU = dir(fullfile([Path Upath]));
nameListR = dir(fullfile([Path Rpath]));
nameListL = dir(fullfile([Path Lpath]));

for i = 1:length(nameListA)-2          %traverse each person
   % cmpEMGA(n).group = fmXls(index);
   
    pathA{i}=fullfile(Path,Apath,nameListA(i+2).name);
    pathU{i}=fullfile(Path,Upath,nameListU(i+2).name);
    cmpEMGA.name{i}=nameListA(i+2).name(1:end-4);
    index = ismember(nameXls,cmpEMGA.name{i});
    cmpEMGA.FM(i) = fmXls(index,1);
    cmpEMGA.group(i) = fmXls(index,2);
    cmpEMGA.EMG{i}=loadEmg(pathA{i});
    cmpEMGA.EMGU{i}=loadEmg(pathU{i});
end
cmpEMGA.name=cmpEMGA.name';
cmpEMGA.FM=cmpEMGA.FM';
cmpEMGA.group=cmpEMGA.group';
cmpEMGA.EMG= cmpEMGA.EMG';
cmpEMGA.EMGU=cmpEMGA.EMGU';
for i = 1:length(nameListR)-2          %traverse each person
    pathR{i}=fullfile(Path,Rpath,nameListR(i+2).name);
    pathL{i}=fullfile(Path,Lpath,nameListL(i+2).name);
    cmpEMGH.name{i}=nameListR(i+2).name(1:end-4);
    cmpEMGH.EMGR{i}=loadEmg(pathR{i});
    cmpEMGH.EMGL{i}=loadEmg(pathL{i});
end
cmpEMGH.name=cmpEMGH.name';
cmpEMGH.EMGR=cmpEMGH.EMGR';
cmpEMGH.EMGL=cmpEMGH.EMGL';