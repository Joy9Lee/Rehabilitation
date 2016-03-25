close all; clear ; clc;
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
addpath('../../SignalProcess');
addpath('../../feature')


%% syndata all
if 1

for i=1:length(SynDataA.name)
    figure(1)
    subplot(4,6,i)
    L(i)=min(length(ang.shdA{i}),length(SynDataA.synEMG{i}));
    plot(ang.shdA{i}(1:L(i)),SynDataA.synEMG{i}(1:L(i),3)./SynDataA.synEMG{i}(1:L(i),2))
    %plot(ang.shdAton{i},SynDataA.synEMG{i}(SynDataA.loc0(i) : SynDataA.loc(i),3)./SynDataA.synEMG{i}(SynDataA.loc0(i) : SynDataA.loc(i),2))
    figure(2)
    subplot(4,6,i)
    Le(i)=min(length(ang.elbA{i}),length(SynDataA.synEMG{i}));
    plot(ang.elbA{i}(1:Le(i)),SynDataA.synEMG{i}(1:Le(i),5)./SynDataA.synEMG{i}(1:Le(i),6))
end
suptitle('affected Anter/Trape PowerRatio')

figure
for i=1:length(SynDataA.name)
    subplot(4,6,i)
    %L(i)=min(length(A.ang{i}),length(A.iEMG{i}));
    %figure
    plot(ang.shdAton{i},SynDataA.synEMG{i}(SynDataA.loc0(i) : SynDataA.loc(i),5)./SynDataA.synEMG{i}(SynDataA.loc0(i) : SynDataA.loc(i),6))
end
suptitle('affected Bice/Trice PowerRatio')

figure
for i=1:length(SynDataU.name)
    subplot(4,6,i)
   % L=min(length(U.ang{i}),length(U.iEMG{i}));
    %figure
     plot(ang.shdCton{i},SynDataU.synEMG{i}(SynDataU.loc0(i) : SynDataU.loc(i),3)./SynDataU.synEMG{i}(SynDataU.loc0(i) : SynDataU.loc(i),2))
    
    %xlabel('Angle')
end
suptitle('Control Anter/Trape PowerRatio')

figure
for i=1:length(SynDataU.name)
    subplot(4,6,i)
   % L=min(length(U.ang{i}),length(U.iEMG{i}));
    %figure
    plot(ang.shdCton{i},SynDataU.synEMG{i}(SynDataU.loc0(i) : SynDataU.loc(i),5)./SynDataU.synEMG{i}(SynDataU.loc0(i) : SynDataU.loc(i),6))
    
    %xlabel('Angle')
end
suptitle('Control Bice/Trice PowerRatio')
end


%% single example
if 1
    a=3;
    c=5;
La=min(length(ang.shdA{a}),length(SynDataA.synEMG{a}));

figure
plot(ang.shdA{a}(1:La),SynDataA.synEMG{a}(1:La,3)./SynDataA.synEMG{a}(1:La,2))
%y=plotfit(A.ang{m}(1:L),A.iEMG{m}(1:L,2));
title('A.syn')
Lc=min(length(ang.shdC{c}),length(SynDataU.synEMG{c}));

figure
plot(ang.shdC{a}(1:Lc),SynDataU.synEMG{c}(1:Lc,3)./SynDataU.synEMG{c}(1:Lc,2))
title('U.syn')

end
%% plot iEMG
if 0
figure
for i=1:length(SynDataA.name)
    subplot(4,6,i)
    %plot(A(i).iEMG(:,2:6))
    plot(A(i).tonE{1}(:,2:6))
end
figure
for i=1:length(SynDataU.name)
    subplot(4,6,i)
    %plot(U(i).iEMG(:,2:6))
    plot(U(i).tonE{1}(:,2:6))
end
end