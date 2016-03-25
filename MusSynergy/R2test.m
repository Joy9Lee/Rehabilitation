close all; clear; clc;
load('../DATA/SynDataA_35');
for i=1:length(SynDataA.name)
    
    SynDataA.EMG{i}=PreProcess(SynDataA.EMG{i});
    SynDataA.EMGU{i}=PreProcess(SynDataA.EMGU{i});
    
    for j=1:7
        NA=j;
        for k=1:50
            
            [~,~,R{i}(j,k),~]=ExtractSynergy(SynDataA.EMG{i}',NA,1000,1);
            
        end
%         if mean(R{i}(j,:))>0.8
%             Na(i)=NA;
%             break
%         end
        mdata3(i,j)=mean(R{i}(j,:));
        sdata3(i,j)=std(R{i}(j,:),1);
        
    end
end

Na=Na';