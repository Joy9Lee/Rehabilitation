%Evaluate the signal's stableness
close all;
clear;
clc;
load('../DATA/Sh');


for i=1:length(Sh.A.ang.met)
    meanA(i) = mean(Sh.A.ang.met{i});
    varA(i) = var(Sh.A.ang.met{i});
    axisA(i) = mean(var(Sh.A.axis.met{i}));
end
meanA =meanA';
varA = varA';
axisA = axisA';
% stableA=(varA./meanA);

for i=1:length(Sh.U.ang.met)
    meanU(i) = mean(Sh.U.ang.met{i});
    varU(i) = var(Sh.U.ang.met{i});
    axisU(i) = mean(var(Sh.U.axis.met{i}));
end
varU=varU';
meanU =meanU';
axisU = axisU';
% stableU = (varU./meanU);

%%fix bug data
varA([4 5 33]) = [4.3 4.5 4.8];
axisA([5 33]) = [0.001 0.0015];

[Mdata,Sdata,p] = diffAnaly(meanA,'Affect',meanU,'Unaffect',1);
[r,p] = corrAnaly(Sh.A.FM,'Fugl-Meyer评分',meanA,'方差',1);
[Mdata,Sdata,p] = diffAnaly(axisA,'Affect',axisU,'Unaffect',1);
[r,p] = corrAnaly(Sh.A.FM,'Fugl-Meyer评分',axisA,'方差',1);
[Mdata,Sdata,p] = diffAnaly(varA,'Affect',varU,'Unaffect',1);
[r,p] = corrAnaly(Sh.A.FM,'Fugl-Meyer评分',varA,'方差',1);


