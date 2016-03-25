close all;
clear;
clc;
addpath('../signalProcess')
load('../DATA/Tru');
load('../DATA/Sh');
%% divide mildly set and severely set of affect
seve = [];
mild = [];
for i =1 : size(Sh.A.FM)
    if Sh.A.FM(i) < 30
        seve = [seve i];
    else
        mild = [mild i];
    end
end
%%
for i=1:length(Tru.A)
    varA(i) = var(Tru.A{i});
end

for i = 1:length(Tru.U)
    varU(i) = var(Tru.U{i});
end
varA = varA';
varU = varU';
[Mdata,Sdata,p] = diffAnaly2(log(varA(seve)),'Severely',log(varA(mild)),'Mildly',log(varU),'Unaffect','躯干平稳度',1);
[Mdata,Sdata,p] = diffAnaly(log(varA),'Affect',log(varU),'Unaffect','躯干平稳度',1);
[r,p] = corrAnaly(Sh.A.FM,'Fugl-Meyer评分',log(varA),'躯干平衡度',1);