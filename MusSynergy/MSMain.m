close all; clear all; clc;
addpath('../DataCollect/loadData');
%% load EMG data & signal preprocess
nameList = dir(fullfile('.','Patients'));
for n = 3:length(nameList)
    list=dir(fullfile('.','Patients',nameList(n).name));
    j=0;k=0;
    %fileList = dir(fullfile('G:','EMGdata',nameList(n).name));
    for i=3:length(list)
        path=fullfile('G:\SNARC\Rehabilitation\MusSynergy\Patients',nameList(n).name,list(i).name);
        if ~isempty(strfind(list(i).name,'R'))
            j=j+1;
            A(n-2).sEMG{j}=loadEmg(path);
            A(n-2).proEMG{j}=PreProcess(A(n-2).sEMG{j});
        elseif  ~isempty(strfind(list(i).name,'L'))
            k=k+1;
            U(n-2).sEMG{k}=loadEmg(path);
            U(n-2).proEMG{k}=PreProcess(U(n-2).sEMG{k});
        end
        
    end
end
%% normalized

for i=1:length(A)
    for j=1:length(A(i).proEMG)
        mEMG(i,j)=max(max(A(i).proEMG{j}));
       
    end
end
maxEMG=max(max(mEMG));
for i=1:length(A)
    for j=1:length(A(i).proEMG)
        A(i).proEMG{j}=A(i).proEMG{j}./maxEMG;
    end
end
%% Extract muscle synergy
N=3;
for i=1:length(A)
    for j=1:length(A(i).proEMG)
%         [H{i,j} W{i,j} R(i,j)]=ExtractSynergy(A(i).proEMG{j},N,20,'d');
%         [W1{i,j} R1(i,j)]=CrsVld(A(i).proEMG{j},H{i},N,20,'d');
         [H{i,j} W{i,j} R(i,j)]=ExtractSynergy(A(i).proEMG{j},N,20);
         [W1{i,j} R1(i,j)]=CrsVld(A(i).proEMG{j},H{i},N,20);
    end
end

if 1
figure 
plot(R,'r*')
hold on
plot(R1,'bo')
end