close all; clear; clc;
%load('../DATA/SynDataA_35');
% load('../DATA/SynDataU_23');
load('../DATA/SynDataA16_M3');
load('../DATA/SynDataU19_M3');

for i=1:length(SynDataA.name)
    
    SynDataA.EMG{i}=PreProcess(SynDataA.EMG{i});
    SynDataA.EMGU{i}=PreProcess(SynDataA.EMGU{i});
    
    for j=1:7
        NA=j;
        for k=1:50
            
            [~,~,R{i}(j,k),~]=ExtractSynergy(SynDataA.EMG{i}',NA,1000,1);
            
        end
        if mean(R{i}(j,:))>0.95
            Na(i)=NA;
            break
        end
        mdata(i,j)=mean(R{i}(j,:));
        sdata(i,j)=std(R{i}(j,:),1);
        
    end
    for j=1:7
        NA=j;
        for k=1:50
            
            [~,~,R2{i}(j,k),~]=ExtractSynergy(SynDataA.EMGU{i}',NA,1000,1);
        end
        if mean(R2{i}(j,:))>0.95
            Nau(i)=NA;
            break
        end
    end
    mdata2(i,j)=mean(R2{i}(j,:));
    sdata2(i,j)=std(R2{i}(j,:),1);
    if 0
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
end
% Nau=Nau';
% Na=Na';
for i=1:length(SynDataU.name)
    
    SynDataU.EMGR{i}=PreProcess(SynDataU.EMGR{i});
    SynDataU.EMGL{i}=PreProcess(SynDataU.EMGL{i});
    
    for j=1:7
        NA=j;
        for k=1:50
            
            [~,~,R3{i}(j,k),~]=ExtractSynergy(SynDataU.EMGR{i},NA,1000,1);
            [~,~,R4{i}(j,k),~]=ExtractSynergy(SynDataU.EMGL{i},NA,1000,1);
        end
        if mean(R3{i}(j,:))>0.95
            Nr(i)=NA;
            break
        end
        
        mdata3(i,j)=mean(R3{i}(j,:));
        sdata3(i,j)=std(R3{i}(j,:),1);
        mdata4(i,j)=mean(R4{i}(j,:));
        sdata4(i,j)=std(R4{i}(j,:),1);
    end
    if 0
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
end
