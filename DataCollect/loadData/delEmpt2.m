%% remove the empty value in synData
close all
clear all
clc
load('../../DATA/backup/SynDataA');
load('../../DATA/backup/SynDataU');
addpath('../../signalProcess')
fs=50;
j=1;
indataA=synDataA;
indataU=synDataU;
%for i=1:length(indataA.sEMGA)  
for i=1:length(indataA.sEMGU)   
    if ~(isempty(indataA.sEMGA{i})||isempty(indataA.sEMGU{i}))
        dataA.name{j}=indataA.name(i);
        dataA.FM(j)=indataA.FM(i);
        dataA.quatA(j)=indataA.quatA(i);
        dataA.quatU(j)=indataA.quatU(i);
        dataA.EMGA{j}=CiEMG(indataA.sEMGA{i},20);
        dataA.EMGU{j}=CiEMG(indataA.sEMGU{i},20);
        dataA.mvcA{j}=indataA.mvcA{i};
        dataA.mvcU{j}=indataA.mvcU{i};
        
        %dataA.EMGT{j}=dataA.EMG{j}(dataA.loc1(j)+1:end,:);
        j=j+1;
    end
end
dataA.name=dataA.name';
dataA.FM=dataA.FM';
dataA.quatA=dataA.quatA';
dataA.quatU=dataA.quatU';
dataA.EMGA= dataA.EMGA';
dataA.EMGU=dataA.EMGU';
dataA.mvcA=dataA.mvcA';
dataA.mvcU=dataA.mvcU';
j=1;
for i=1:length(indataU.sEMG)   
    if ~(isempty(indataU.sEMG{i}))
        dataU.name{j}=indataU.name(i);
        dataU.quat(j)=indataU.quat(i);
        dataU.EMG{j}=CiEMG(indataU.sEMG{i},20);
        dataU.mvc{j}=indataU.mvc{i}; 
        j=j+1;
    end
end
dataU.name=dataU.name';
dataU.quat=dataU.quat';
dataU.EMG=dataU.EMG';
dataU.mvc=dataU.mvc';