% powSeq.m 
% put the power ratio of EMG in every muscle in descending order  

close all; clear all; clc
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');
addpath('../../SignalProcess');
addpath('../../quaternion')
addpath('../../feature')
PwRatioA=PowerRatio(SynDataA.synEMG);
PwRatioC=PowerRatio(SynDataU.synEMG);
[A,seqA]=sort(PwRatioA,2,'descend');
[C,seqC]=sort(PwRatioC,2,'descend');
sqC=[3 4 5 6 1 2 7];
if 0
figure
bar(PwRatioA)
set(gca,'xticklabel',num2str(SynDataA.FM))
legend('胸大肌','斜方肌','三角肌前组','三角肌中组','肱二头肌','肱三头肌','肱桡机');
figure
bar(PwRatioC)
legend('胸大肌','斜方肌','三角肌前组','三角肌中组','肱二头肌','肱三头肌','肱桡机');
end

for i=1:length(SynDataA.name)
    %s(i)=similarity(PwRatioA(i,:),sqC);
    sA(i)=similarity(seqA(i,1:3),sqC(1:3));
 
    if 0
    figure(3)
    subplot(5,5,i)
    bar(PwRatioA(i,:))
    %bar(s(i))
    set(gca,'xticklabel',num2str(SynDataA.FM(i)))
    %title(['FM=' num2str(SynDataA.FM(i))]);
    end
end
for i=1:length(SynDataU.name)
     sC(i)=similarity(seqC(i,1:3),sqC(1:3))
end
mycorr(SynDataA.FM',sA,SynDataA.FM,1);
