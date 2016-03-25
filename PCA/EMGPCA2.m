close all;clear ;clc
load('../DATA/SynDataA_39');
load('../DATA/SynDataU_25');
load('../DATA/locA');
load('../DATA/locH');
addpath('../SignalProcess')
cla='h';
for i=1:length(SynDataA.EMG)
    SynDataA.EMG{i}=EMGPre(SynDataA.EMG{i});
    EMGA{i}=winRMS(SynDataA.EMG{i},20);
    EMGA1{i}=EMGA{i}(1:locA(i)-1,:);                %flx
    EMGA2{i}=EMGA{i}(locA(i):end,:);                 %hold
    meanA1(i,:)=mean(EMGA1{i});
    meanA2(i,:)=mean(EMGA2{i});
    meanA(i,:)=mean(EMGA{i});       
end
for i=1:length(SynDataU.name)
   SynDataU.EMGR{i}=EMGPre(SynDataU.EMGR{i});
   EMGU{i}=winRMS(SynDataU.EMGR{i},20);
   meanU(i,:)=mean(EMGU{i}); 
end
[group,Grp1,Grp2]=group2(SynDataA.group,cla);
meanAll=[meanA;meanU];
meanA1=zscore(meanA,1);

[coeff,score,latent]=pca(meanA);
conRate=cumsum(latent)./sum(latent);            %求出各个主成分的贡献率
% figure
% pareto(latent)
%[idx,C] = kmeans(score(:,1:2),4);
for i=1:64
    if 0
    figure(2)
    
    switch group(i)
   
        case 1
            plot(score(i,1),score(i,2),'o','MarkerFaceColor','b')
            hold on
            text(score(i,1),score(i,2)+0.3,num2str(group(i)))
        case 2
            plot(score(i,1),score(i,2),'o','MarkerFaceColor','c')
            hold on
            text(score(i,1),score(i,2)+0.3,num2str(group(i)))
        case 3
            plot(score(i,1),score(i,2),'o','MarkerFaceColor','r')
            hold on
            text(score(i,1),score(i,2)+0.3,num2str(group(i)))
        case 4
            plot(score(i,1),score(i,2),'o','MarkerFaceColor','g')
            hold on
            text(score(i,1),score(i,2)+0.3,num2str(group(i)))
        case 5
            plot(score(i,1),score(i,2),'o','MarkerFaceColor','y')
            hold on
            text(score(i,1),score(i,2)+0.3,num2str(group(i)))
    end
    
    
    grid on
    end
end
data=score(:,1:2);
[train, test] = crossvalind('HoldOut', SynDataA.group);
% [bestacc,bestc,bestg] = SVMcg(double(SynDataA.group(train)),data(train,:),-2,4,-4,4,3,0.5,0.5,0.9);
% cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
% model = svmtrain(double(SynDataA.group(train)),data(train,:),cmd);
% 
% [predict_label, accuracy, dec_values] = svmpredict(SynDataA.group(test), data(test,:), model);
cp = classperf(group); 
svmStruct = svmtrain(data(train,:),group(train),'showplot',true);
classes = svmclassify(svmStruct,data(test,:),'showplot',true);
classperf(cp,classes,test);
cp.CorrectRate
% for i=1:length(SynDataA.EMG)
%     figure(2)
%     plot3(score(i,1),score(i,2),score(i,3),'o')
%     hold on
%     text(score(i,1),score(i,2),score(i,3)+0.3,num2str(SynDataA.group(i)))
%     grid on
% end
%      figure
%      plot(score)
% %      bar(latent)
%      title(num2str(SynDataA.group(i)))
% %      ylim([0 0.3])