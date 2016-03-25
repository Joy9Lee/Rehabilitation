close all; clear; clc;
load('../DATA/SynDataA_39');
load('../DATA/SynDataU_25');


for i=1:21
    
    SynDataA.EMG{i}=PreProcess(SynDataA.EMG{i});
    SynDataA.EMGU{i}=PreProcess(SynDataA.EMGU{i});
    
    for j=1:7
        NA=j;
        for k=1:50
            
            [~,~,R{i}(j,k),~]=ExtractSynergyW(SynDataA.EMG{i}',NA,1000,1);
            [~,~,R2{i}(j,k),~]=ExtractSynergyW(SynDataA.EMGU{i}',NA,1000,1);
        end
        mdata(i,j)=mean(R{i}(j,:));
        sdata(i,j)=std(R{i}(j,:),1);
        mdata2(i,j)=mean(R2{i}(j,:));
        sdata2(i,j)=std(R2{i}(j,:),1);
    end
    
    figure
    %        subplot(2,1,1)
    %    plot(R{i}(j,:),'--o')
    errorbar(mdata(i,:),sdata(i,:))
    ylim([0 1])
    xlim([0 7])
    xlabel('N')
    ylabel('R^2')
    title('affected side')
    %     subplot(2,1,2)
    figure
    %plot(R2{i}(j,:),'--o')
    errorbar(mdata2(i,:),sdata2(i,:))
    ylim([0 1])
    xlim([0 7])
    xlabel('N')
    ylabel('R^2')
    title('unaffected side')
end
for i=1:length(SynDataU.name)
    
    SynDataU.EMGR{i}=PreProcess(SynDataU.EMGR{i});
    SynDataU.EMGL{i}=PreProcess(SynDataU.EMGL{i});
    
    for j=1:7
        NA=j;
        for k=1:50
            
            [~,~,R3{i}(j,k),~]=ExtractSynergyW(SynDataU.EMGR{i}',NA,1000,1);
            [~,~,R4{i}(j,k),~]=ExtractSynergyW(SynDataU.EMGL{i}',NA,1000,1);
        end
        mdata3(i,j)=mean(R3{i}(j,:));
        sdata3(i,j)=std(R3{i}(j,:),1);
        mdata4(i,j)=mean(R4{i}(j,:));
        sdata4(i,j)=std(R4{i}(j,:),1);
    end
    
    figure
    %        subplot(2,1,1)
    %   plot(R(i,:),'--o')
    errorbar(mdata3(i,:),sdata3(i,:))
    ylim([0 1])
    xlim([0 7])
    %      subplot(2,1,2)
    %     plot(R2(i,:),'--o')
    figure
    errorbar(mdata4(i,:),sdata4(i,:))
    ylim([0 1])
    xlim([0 7])
end
