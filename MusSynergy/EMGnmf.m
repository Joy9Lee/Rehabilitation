close all; clear ; clc;
load('../DATA/SynDataA_35');
load('../DATA/SynDataU_23');
addpath('../SignalProcess');
addpath('../feature')
N=3;
for i=1:length(SynDataA.name)
    SynDataA.EMG{i}=PreProcess(SynDataA.EMG{i});
    [H{i},W{i},R(i),D(i)]=ExtractSynergy(SynDataA.EMG{i},N,20);
    SynDataA.EMGU{i}=PreProcess(SynDataA.EMGU{i});
    [H2,W2,R2(i),D2(i)]=ExtractSynergy(SynDataA.EMGU{i},N,20);
%     [s(i)] = similarity(H(1,:),H2(1,:));
%     figure
%     for j=1:7
%         subplot(7,1,j)
%         plot(SynDataA.EMG{i}(:,j))
%     end
%     figure
%     for j=1:N
%         subplot(N,1,j)
%         plot(W(:,j));
%     end
%     suptitle(['Grp=',num2str(SynDataA.group(i)),'FM=',num2str(SynDataA.FM(i))])
%     figure
%     for j=1:N
%         subplot(1,N,j);
%         barh(H(j,:));
%     end
%     suptitle(SynDataA.name{i});
%     %suptitle(['Grp=',num2str(SynDataA.group(i)),'FM=',num2str(SynDataA.FM(i))])
%     figure
%     for j=1:N
%         subplot(1,N,j);
%         barh(H2(j,:));
%     end
%     suptitle(SynDataA.name{i});
%     %suptitle(['Grp=',num2str(SynDataA.group(i)),'FM=',num2str(SynDataA.FM(i))])
end
for i=1:length(SynDataU.name)
    SynDataU.EMGR{i}=PreProcess(SynDataU.EMGR{i});
    [H3,W3,R3(i),D3(i)]=ExtractSynergy(SynDataU.EMGR{i},N,20);
    SynDataU.EMGL{i}=PreProcess(SynDataU.EMGL{i});
    [H4,W4,R4(i),D4(i)]=ExtractSynergy(SynDataU.EMGL{i},N,20);
    [s2(i)] = similarity(H3(1,:),H4(1,:));
%     figure
%     for j=1:7
%         subplot(7,1,j)
%         plot(SynDataA.EMG{i}(:,j))
%     end
if 0
     figure
    for j=1:N
        subplot(N,1,j)
        plot(W3(:,j));
    end
    %suptitle(['Grp=',num2str(SynDataA.group(i)),'FM=',num2str(SynDataA.FM(i))])
    figure
    for j=1:N
        subplot(1,N,j);
        barh(H3(j,:));
    end
    suptitle(SynDataA.name{i});
    %suptitle(['Grp=',num2str(SynDataA.group(i)),'FM=',num2str(SynDataA.FM(i))])
    figure
    for j=1:N
        subplot(1,N,j);
        barh(H4(j,:));
    end
    suptitle(SynDataA.name{i});
%     %suptitle(['Grp=',num2str(SynDataA.group(i)),'FM=',num2str(SynDataA.FM(i))])
end
end
