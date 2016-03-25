close all;
clear;
clc;
addpath('../DATA')
load('synDataA');
load('synDataU');
synDataA=SynDataA;
%%
affectInput=[0,0,0,0,0,0];
affectOutput=[0];
unaffectInput=[0,0,0,0,0,0];
unaffectOutput=[0];
affect=struct('input',{},'output',{});
unaffect=struct('input',{},'output',{});
for i=1:10
    input=zeros(length(synDataA(i).sEMG),6);
    synDataA(i).ang.shd.adb=synDataA(i).ang.shd.adb(1:length(synDataA(i).sEMG));
    synDataA(i).ang.elb.adb=synDataA(i).ang.elb.adb(1:length(synDataA(i).sEMG));
    input=[synDataA(i).ang.shd.adb, synDataA(i).ang.elb.adb, synDataA(i).sEMG(:,1), synDataA(i).sEMG(:,2), synDataA(i).sEMG(:,3), synDataA(i).sEMG(:,4)]
    affect(i).output=input(2:end, 1)-input(1:end-1,1);
%     affect(i).output=input(2:end, 1);
    affect(i).input=input(1:end-1,:);
    affectInput=[affectInput;affect(i).input];
    affectOutput=[affectOutput;affect(i).output];
end
    [net] = NNfit(affect(i).input', affect(i).output');
for i=1:10
    input=zeros(length(synDataA(i).sEMG),6);
    synDataU(i).ang.shd.adb=synDataU(i).ang.shd.adb(1:length(synDataU(i).sEMG));
    synDataU(i).ang.elb.adb=synDataU(i).ang.elb.adb(1:length(synDataU(i).sEMG));
    input=[synDataU(i).ang.shd.adb, synDataU(i).ang.elb.adb, synDataU(i).sEMG(:,1), synDataU(i).sEMG(:,2), synDataU(i).sEMG(:,3), synDataU(i).sEMG(:,4)]
    unaffect(i).output=input(2:end, 1)-input(1:end-1,1);
%     unaffect(i).output=input(2:end, 1);
    unaffect(i).input=input(1:end-1,:);    
    unaffectInput=[unaffectInput;unaffect(i).input];
    unaffectOutput=[unaffectOutput;unaffect(i).output];
%   [targets, outputs] = NNfit(unaffect(i).input', unaffect(i).output')
%   plotregression(targets,outputs);

end
    [net] = NNfit(unaffect(i).input', unaffect(i).output');
%%
