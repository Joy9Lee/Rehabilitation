close all; clear; clc;
load('../DATA/SynDataA16_M3');
load('../DATA/SynDataU19_M3');
addpath('G:\SNARC\Rehabilitation\feature');
addpath('G:\SNARC\Rehabilitation\SignalProcess');
NA=4;
NH=4;
display=0;
cla='h';
Sy1=[];
Sy2=[];
Sy3=[];
Sy4=[];

figure
for i=1:length(SynDataA.name)         %affect
    
    SynDataA.EMG{i}=PreProcess(SynDataA.EMG{i});
    SynDataA.EMGU{i}=PreProcess(SynDataA.EMGU{i});
    [W{i},H{i},R(i)]=ExtractSynergy(SynDataA.EMG{i}',NA,1000,5);
    [W2{i},H2{i},R2(i)]=ExtractSynergy(SynDataA.EMGU{i}',NA,1000,5);
    [group,Grp1,Grp2]=group2(SynDataA.group,cla);
    
    
    for j=1:NA
        
        subplot(8,8,(i-1)*NA+j)
        barh(W{i}(:,j)/8);
        xlim([0 1])
    end
    Sy1=[Sy1 W{i}(:,1)];
    Sy2=[Sy2 W{i}(:,2)];
    Sy3=[Sy3 W{i}(:,3)];
    Sy4=[Sy4 W{i}(:,4)];
    
end
figure
bar(Sy1)
figure
bar(Sy2)
figure
bar(Sy3)
figure
bar(Sy4)
figure

for i=1:length(SynDataU.name)            %healthy
    SynDataU.EMGL{i}=PreProcess(SynDataU.EMGL{i});
    SynDataU.EMGR{i}=PreProcess(SynDataU.EMGR{i});
    [W3{i},H3{i},R3(i),D3(i)]=ExtractSynergy(SynDataU.EMGR{i}',NH,1000,5);
    [W4{i},H4{i},R4(i),D4(i)]=ExtractSynergy(SynDataU.EMGL{i}',NH,1000,5);
    for j=1:NH
        subplot(9,9,(i-1)*NH+j)
        barh(W3{i}(:,j)/8);
        xlim([0 1])
    end
    
end
