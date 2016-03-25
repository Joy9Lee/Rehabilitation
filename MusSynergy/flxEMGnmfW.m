close all; clear; clc;
load('../DATA/SynDataA_39');
load('../DATA/SynDataU_25');
addpath('G:\SNARC\Rehabilitation\feature');
addpath('G:\SNARC\Rehabilitation\SignalProcess');
N=1;
NA=3;
NH=3;
display=0;
cla='h';
meansim=[];

for i=1:21            %affect
   
    SynDataA.EMG{i}=PreProcess(SynDataA.EMG{i});
    SynDataA.EMGU{i}=PreProcess(SynDataA.EMGU{i});

    
       
    [H{i},W{i},R(i)]=ExtractSynergyW(SynDataA.EMG{i}',NA,1000,5);
    [H2{i},W2{i},R2(i)]=ExtractSynergyW(SynDataA.EMGU{i}',NA,1000,5);
    [sim{i},m{i},s1{i}]=synergySim(W{i},W2{i},NA);
    [sim{i},u]=sort(sim{i},'descend');
    meansA(i)=mean(sim{i});
    [group,Grp1,Grp2]=group2(SynDataA.group,cla);
   
    m{i}=m{i}(u);
    W{i}=W{i}(:,u);
   meansim=[meansim mean(sim{i})];
    %     for j=1:N
    %         [s(i,j)] = similarity(H{i}(j,:),H2{i}(j,:));
    %     end
    if 1
    figure
    for j=1:NA
        subplot(2,NA,j);
        barh(W{i}(:,j));
        
   %     title(sim{i}(j))
        subplot(2,NA,j+NA);
        barh(W2{i}(:,m{i}(j)));
 
        
    end
     suptitle([num2str(i), 'FM=',num2str(SynDataA.FM(i))]);
    end
    if display
%         figure
%         for j=1:NA
%             subplot(NA,1,j)
%             plot(W{i}(:,j));
%         end
        %suptitle(['Grp=',num2str(SynDataA.group(i)),'FM=',num2str(SynDataA.FM(i))])
        figure
        
        for j=1:NA
            subplot(2,NA,j);
            barh(H{i}(j,:));
           
            subplot(2,NA,j+NA);
            barh(H2{i}(m{i}(j),:));
            
        end
        suptitle([num2str(i), 'FM=',num2str(SynDataA.FM(i))]);
    %    figure

%         for j=1:NA
%             subplot(1,NA,j);
%             barh(H2{i}(j,:));
%         end
%         suptitle([SynDataA.name{i},'FM=',num2str(SynDataA.FM(i))]);
    end
end
    
%   meansim(19)=[];
% SynDataA.FM(19)=[];
[r,p]=corrAnaly(meansim','sim',SynDataA.FM(1:21),'FM',0);



mean(r);
 
 meanA=mean(meansA);
 stdA=std(meansA);
for i=1:length(SynDataU.name)            %healthy
    SynDataU.EMGL{i}=PreProcess(SynDataU.EMGL{i});
    SynDataU.EMGR{i}=PreProcess(SynDataU.EMGR{i});
    [H3{i},W3{i},R3(i),D3(i)]=ExtractSynergy(SynDataU.EMGR{i},NH,20);
    [H4{i},W4{i},R4(i),D4(i)]=ExtractSynergy(SynDataU.EMGL{i},NH,20);
    [sim2{i},m2{i},s2{i}]=synergySim(H3{i},H4{i},NH);
    
    [sim2{i},u2]=sort(sim2{i},'descend');
    m2{i}=m2{i}(u2);
    H3{i}=H3{i}(u2,:);
    meansH(i)=mean(sim2{i});
    if 0
    figure
    for j=1:NH
        subplot(2,NH,j);
        barh(H3{i}(j,:));
        title(sim2{i}(j))
        subplot(2,NH,j+NH);
        barh(H4{i}(m2{i}(j),:));
    end
    end
    %     for j=1:N
    %         [s2(i,j)] = similarity(H3{i}(j,:),H4{i}(j,:));
    %     end
    if display
        figure
        for j=1:NH
            subplot(NH,1,j)
            plot(W3{i}(:,j));
        end
        %suptitle(['Grp=',num2str(SynDataA.group(i)),'FM=',num2str(SynDataA.FM(i))])
        figure
        for j=1:NH
            subplot(1,NH,j);
            barh(H3{i}(j,:));
        end
        suptitle(SynDataU.name{i});
        figure
        for j=1:NH
            subplot(1,NH,j);
            barh(H4{i}(j,:));
        end
        suptitle(SynDataU.name{i});
        figure
        for j=1:NH
            subplot(2,NH,j);
            barh(H3{i}(j,:));
            title(sim2{i}(j))
            subplot(2,NH,j+3);
            barh(H4{i}(m2{i},:));
        end
    end
end
meanH=mean(meansH);
stdH=std(meansH);

[Mdata,Sdata,p1,p2]=group2BarPlot(SynDataA.group,'b',meansA,meansH);