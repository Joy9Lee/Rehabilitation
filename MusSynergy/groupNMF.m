close all; clear ; clc;
load('../DATA/SynDataA_39');
load('../DATA/SynDataU_25');
addpath('../SignalProcess');
addpath('../feature')
N=3;
grp1EMG=[];
grp2EMG=[];
grp3EMG=[];
grp4EMG=[];
for i=1:length(SynDataA.EMG)
    SynDataA.EMG{i}=PreProcess(SynDataA.EMG{i});
    [Grp1,Grp2,Grp3,Grp4]=group4(SynDataA.group);
   % [H{i},W{i},R(i),D(i)]=ExtractSynergy(SynDataA.EMG{i},N,20);
    %SynDataA.EMGU{i}=PreProcess(SynDataA.EMGU{i});
    
end
for j=1:length(Grp1)
   grp1EMG=[grp1EMG;SynDataA.EMG{Grp1(j)}];
   % grp1EMG=[grp1EMG,SynDataA.EMG{Grp1(j)}(1:200,:)];
end
[H{i},W{i},R(i),D(i)]=ExtractSynergy(grp1EMG,N,20,1);
for j=1:length(Grp2)
   grp2EMG=[grp2EMG;SynDataA.EMG{Grp2(j)}];
  %  grp2EMG=[grp2EMG,SynDataA.EMG{Grp2(j)}(1:200,:)];
end
[H2{i},W2{i},R2(i),D2(i)]=ExtractSynergy(grp2EMG,N,20,1);
for j=1:length(Grp3)
   grp3EMG=[grp3EMG;SynDataA.EMG{Grp3(j)}];
   % grp3EMG=[grp3EMG,SynDataA.EMG{Grp3(j)}(1:200,:)];
end
[H3{i},W3{i},R3(i),D3(i)]=ExtractSynergy(grp3EMG,N,20,1);
for j=1:length(Grp4)
   grp4EMG=[grp4EMG;SynDataA.EMG{Grp4(j)}];
  %  grp4EMG=[grp4EMG,SynDataA.EMG{Grp4(j)}(1:200,:)];
end
[H4{i},W4{i},R4(i),D4(i)]=ExtractSynergy(grp4EMG,N,20,1);
% grp1EMG=SynDataA.EMG{Grp1};
% grp2EMG=SynDataA.EMG{Grp2};
% grp3EMG=SynDataA.EMG{Grp3};
% grp4EMG=SynDataA.EMG{Grp4};
