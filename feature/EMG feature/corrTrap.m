%% ratio为三角肌前组的归一化值
close all
clear all
clc
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');
addpath('../../SignalProcess')
addpath('../../feature')
mRatioA=[];
mRatioU=[];
 for i=1:length(SynDataA.ratio)-1
     %mRatioA{i}=mean(SynDataA.rT{i}); 
     %mRatioA=[mRatioA;mean(SynDataA.rT{i})]; 
    meanA(i)=mean(SynDataA.ratio{i}(SynDataA.loc(i)+1:end));
    varA(i)=var(SynDataA.ratio{i}(SynDataA.loc(i)+1:end));
    varA1(i)=var(SynDataA.ratio{i}(1:SynDataA.loc(i)));
    FM(i)=SynDataA.FM(i);
 end
 for i=1:length(SynDataU.ratio)
     %mRatioU=[mRatioU;mean(SynDataU.rT{i})]; 
      meanU(i)=mean(SynDataU.ratio{i}(SynDataU.loc(i)+1:end));
      varU(i)=var(SynDataU.ratio{i}(SynDataU.loc(i)+1:end));
      varU1(i)=var(SynDataU.ratio{i}(1:SynDataU.loc(i)));
 end
 if 0
 figure
 plot(meanA,'*r')
 hold on
 plot(meanU,'.b')
 end
   
seve = [];
mild = [];
for i =1 : size(SynDataA.FM)-1
    if SynDataA.FM(i) < 30
        seve = [seve i];
    else
        mild = [mild i];
    end
end
    %% similarity
    for j=1:length(SynDataA.ratio)
        s(i) = similarity(meanA(i),mean(meanU));
    end
%% diffrence
[Mdata,Sdata,p1]=diffAnaly2(meanA,'Affected side',meanU,'Control','平均募集率',1);
[Mdata,Sdata,p2]=diffAnaly2(varA,'Affected side',varU,'Control','募集率方差',1);
[Mdata,Sdata,p2]=diffAnaly2(varA1,'Affected side',varU1,'Control','上升阶段募集率方差',1);
[Mdata,Sdata,p3] = diffAnaly(varA(seve),'Severely',varA(mild),'Mildly',varU,'Control','募集率方差',1);

[Mdata,Sdata,p3] = diffAnaly(meanA(seve),'Severely',meanA(mild),'Mildly',meanU,'Control','平均募集率',1);

%log
% [Mdata,Sdata,p4]=diffAnaly2(log(meanA),'Affected',log(meanU),'Unaffected','log平均募集率',1);
% [Mdata,Sdata,p5]=diffAnaly2(log(varA),'Affected',log(varU),'Unaffected','log募集率方差',1);
% [Mdata,Sdata,p6]=diffAnaly(log(varA(seve)),'Severely',log(varA(mild)),'Mildly',log(varU),'Unaffect','log募集率方差',1);
% [Mdata,Sdata,p3] = diffAnaly(log(meanA(seve)),'Severely',log(meanA(mild)),'Mildly',log(meanU),'Unaffect','log平均募集率',1);
%% corr


[r,p7]=corrAnaly(FM','Fugl-Meyer评分',log(varA'),'logVAR',1);
[r,p8]=corrAnaly(FM','Fugl-Meyer评分',varA','VAR',1);
[r,p9]=corrAnaly(FM','Fugl-Meyer评分',log(meanA'),'logMEAN',1);
[r,p]=corrAnaly(FM','Fugl-Meyer评分',meanA','MEAN',1);