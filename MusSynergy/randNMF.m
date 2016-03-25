close all; clear; clc;
load('../DATA/cmpEMGA');
load('../DATA/cmpEMGH');
addpath('G:\SNARC\Rehabilitation\feature');
addpath('G:\SNARC\Rehabilitation\SignalProcess');
N=1;
NA=4;
NH=4;
display=0;
cla='h';
index=randperm(14);
for i=1:length(cmpEMGA.name)            %affect
    
    cmpEMGA.EMG{index(i)}=PreProcess(cmpEMGA.EMG{index(i)});
    cmpEMGA.EMGU{index(i)}=PreProcess(cmpEMGA.EMGU{index(i)});
    [H{i},W{i},R(i),D(i)]=ExtractSynergy(cmpEMGA.EMG{index(i)},NA,1000,5);
    [H2{i},W2{i},R2(i),D2(i)]=ExtractSynergy(cmpEMGA.EMGU{index(i)},NA,1000,5);
    [sim{i},m{i},s1{i}]=synergySim(H{i},H2{i},NA);
    [sim{i},u]=sort(sim{i},'descend');
    meansA(i)=mean(sim{i}); 
    [group,Grp1,Grp2]=group2(cmpEMGA.group,cla);
   
    m{i}=m{i}(u);
    H{i}=H{i}(u,:);
    %     for j=1:N
    %         [s(i,j)] = similarity(H{i}(j,:),H2{i}(j,:));
    %     end
    if 1
    figure
    for j=1:NA
        subplot(2,NA,j);
        barh(H{i}(j,:));
        title(sim{i}(j))
        subplot(2,NA,j+NA);
        barh(H2{i}(m{i}(j),:));
    end
    suptitle([cmpEMGA.name{index(i)},'FM=',num2str(cmpEMGA.FM(index(i)))]);
    end
    if display
        figure
        for j=1:NA
            subplot(NA,1,j)
            plot(W{i}(:,j));
        end
        %suptitle(['Grp=',num2str(SynDataA.group(i)),'FM=',num2str(SynDataA.FM(i))])
        figure
        for j=1:NA
            subplot(1,NA,j);
            barh(H{i}(j,:));
        end
        suptitle([cmpEMGA.name{i},'FM=',num2str(cmpEMGA.FM(i))]);
        figure
        for j=1:NA
            subplot(1,NA,j);
            barh(H2{i}(j,:));
        end
        suptitle([cmpEMGA.name{i},'FM=',num2str(cmpEMGA.FM(i))]);
    end
end
 meanA1=mean(meansA(Grp1));
 meanA2=mean(meansA(Grp2));
 meanA=mean(meansA);
 stdA=std(meansA);
for i=1:length(cmpEMGH.name)            %healthy
    cmpEMGH.EMGL{i}=PreProcess(cmpEMGH.EMGL{i});
    cmpEMGH.EMGR{i}=PreProcess(cmpEMGH.EMGR{i});
    [H3{i},W3{i},R3(i),D3(i)]=ExtractSynergy(cmpEMGH.EMGR{i},NH,1000,5);
    [H4{i},W4{i},R4(i),D4(i)]=ExtractSynergy(cmpEMGH.EMGL{i},NH,1000,5);
    [sim2{i},m2{i},s2{i}]=synergySim(H3{i},H4{i},NH);
    
    [sim2{i},u2]=sort(sim2{i},'descend');
    m2{i}=m2{i}(u2);
    H3{i}=H3{i}(u2,:);
    meansH(i)=mean(sim2{i});
    if 1
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
        suptitle(cmpEMGH.name{i});
        figure
        for j=1:NH
            subplot(1,NH,j);
            barh(H4{i}(j,:));
        end
        suptitle(cmpEMGH.name{i});
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

[Mdata,Sdata,p1,p2]=group2BarPlot(cmpEMGA.group,'b',meansA,meansH);