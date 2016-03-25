close all;clear ;clc
load('../DATA/SynDataA_39');
load('../DATA/SynDataU_25');
load('../DATA/locA');
load('../DATA/locH');
addpath('../SignalProcess')
N=3;
grp1EMG=[];
grp2EMG=[];
grp3EMG=[];
grp4EMG=[];
for i=1:37
    SynDataA.EMG{i}=PreProcess(SynDataA.EMG{i});
    [Grp1,Grp2,Grp3,Grp4]=group4(SynDataA.group);
    %iEMGA{i}=winRMS(SynDataA.EMG{i},20);
    EMGA{i}=SynDataA.EMG{i};
    %EMGA{i}=iEMGA{i}(1:200,:);
    [coeff{i},score{i},latent{i}]=pca(EMGA{i});
    conRate{i}=cumsum(latent{i})./sum(latent{i});   
   
    if 0
        figure(1)
        subplot(5,8,i)
        plot(EMGA{i})
         figure
    bar(coeff{i})
    title(['Grp=',num2str(SynDataA.group(i))])
        
    end
end
for j=1:length(Grp1)
   grp1EMG=[grp1EMG;SynDataA.EMG{Grp1(j)}];
   % grp1EMG=[grp1EMG,SynDataA.EMG{Grp1(j)}(1:200,:)];
end
[coeff1{i},score1{i},latent1{i}]=mypca(grp1EMG,N,1);
for j=1:length(Grp2)
   grp2EMG=[grp2EMG;SynDataA.EMG{Grp2(j)}];
  %  grp2EMG=[grp2EMG,SynDataA.EMG{Grp2(j)}(1:200,:)];
end
[coeff2{i},score2{i},latent2{i}]=mypca(grp2EMG,N,1);
for j=1:length(Grp3)
   grp3EMG=[grp3EMG;SynDataA.EMG{Grp3(j)}];
   % grp3EMG=[grp3EMG,SynDataA.EMG{Grp3(j)}(1:200,:)];
end
[coeff3{i},score3{i},latent3{i}]=mypca(grp3EMG,N,1);
for j=1:length(Grp4)
   grp4EMG=[grp4EMG;SynDataA.EMG{Grp4(j)}];
  %  grp4EMG=[grp4EMG,SynDataA.EMG{Grp4(j)}(1:200,:)];
end
[coeff4{i},score4{i},latent4{i}]=mypca(grp4EMG,N,1);