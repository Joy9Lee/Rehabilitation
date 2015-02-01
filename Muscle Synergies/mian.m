close all;
clc;
%clear;
nameList = dir(fullfile('.','unaffect'));
sEMG=cell(1,length(nameList)-2);
for n = 3:length(nameList)
    %list=dir(fullfile('G:','dynamic data',nameList(n).name));
    %fileList = dir(fullfile('G:','EMGdata',nameList(n).name));
    path=fullfile('.','unaffect',nameList(n).name);
    sEMG{n-2}=load(path);
end
sim=zeros(1,length(sEMG)/2)';
for i = 1:(length(sEMG)/2)
    sim(i)=synAnalysis(sEMG{2*i-1},sEMG{2*i},3,'d');
end
Mean=mean(sim);
Var=var(sim);