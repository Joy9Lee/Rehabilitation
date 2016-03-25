% syn.m
% plot the iEMG with ang 
close all; clear all; clc;
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');
addpath('../../SignalProcess');
addpath('../../quaternion')
addpath('../../feature')
SHD=2;
ELB=5;
%% affected shoulder & elbow angle
for i=1:length(SynDataA.name)
    for j=1:4
        
        A(i).ang{j}=quatfac(SynDataA.quat(i).limb{j});                      % shoulder angle:A(i).ang{SHD}
        %A(i).ang{j}=quat2angle(SynDataA.quat(i).limb{j});
    
    end                                                                       % elbow angle:A(i).ang{ELB}
end
% segment
for i=1:length(SynDataA.name)
    %A.ang{i}=quatfac(SynDataA.quat(i).limb{2});
    A(i).tonA{1}=A(i).ang{SHD}(SynDataA.loc0(i) : SynDataA.loc(i));         % shoulder angle
    %A.ang.met{i}=A(i).angA{PART}(kineA.loc1(i) : end);
end
%% control shoulder angle
for i=1:length(SynDataU.name)
    for j=1:4
       U(i).ang{j}=quatfac(SynDataU.quat(i).limb{j});
    end
    %U.ang{i}=quatfac(SynDataU.quat(i).limb{2});
end
% segment
for i=1:length(SynDataU.name)
    %A.ang{i}=quatfac(SynDataA.quat(i).limb{2});
    U(i).tonA{1}=U(i).ang{SHD}(SynDataU.loc0(i) : SynDataU.loc(i));         %shoulder angle
    %A.ang.met{i}=A(i).angA{PART}(kineA.loc1(i) : end);
end

%% plot angle
if 1
figure
for i=1:length(SynDataA.name)
    subplot(4,6,i)
     plot( A(i).ang{SHD}/90)
     %plot(A(i).ang{ELB})
     hold on;
     plot([SynDataA.loc(i) SynDataA.loc(i)],[0 1],'--m');
     plot([SynDataA.loc0(i) SynDataA.loc0(i)],[0 1],'--k');
end
figure
for i=1:length(SynDataU.name)
    subplot(4,6,i)
    plot( U(i).ang{SHD}/90)
%    plot( U(i).ang{ELB})

    hold on
    plot([SynDataU.loc(i) SynDataU.loc(i)],[0 1],'--m');
    plot([SynDataU.loc0(i) SynDataU.loc0(i)],[0 1],'--k');
end
end

% plot ton angle
if 0
figure
for i=1:length(SynDataA.name)
    subplot(4,6,i)
    plot( A(i).tonA{1}/90)
end
figure
for i=1:length(SynDataU.name)
    subplot(4,6,i)
    plot( U(i).tonA{1}/90)
end
end
% A.ang=A.ang';
% U.ang=U.ang';
% iEMG

for i=1:length(SynDataA.EMG)
    A(i).iEMG=CiEMG(SynDataA.EMG{i},20);
end
for i=1:length(SynDataU.EMG)
    U(i).iEMG=CiEMG(SynDataU.EMG{i},20);
end

segment
for i=1:length(SynDataA.name)
    A(i).tonE{1}=A(i).iEMG(SynDataA.loc0(i) : SynDataA.loc(i),:);         %shoulder angle
    
end
for i=1:length(SynDataU.name)
    U(i).tonE{1}=U(i).iEMG(SynDataU.loc0(i) : SynDataU.loc(i),:);         %shoulder angle
    
end

% % diff
% for i=1:length(SynDataA.name)
%     for j=1: length(A(i).tonE{1})
%         d(i)=
% 
% end

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
%% syndata all
if 0
figure
for i=1:length(SynDataA.name)
    subplot(4,6,i)
    %L(i)=min(length(A.ang{i}),length(A.iEMG{i}));
    %figure
    plot(A(i).tonA{1},A(i).tonE{1}(:,3)./A(i).tonE{1}(:,2))
end
suptitle('affected Anter/Trape PowerRatio')

figure
for i=1:length(SynDataA.name)
    subplot(4,6,i)
    %L(i)=min(length(A.ang{i}),length(A.iEMG{i}));
    %figure
    plot(A(i).tonA{1},A(i).tonE{1}(:,5)./A(i).tonE{1}(:,6))
end
suptitle('affected Bice/Trice PowerRatio')

figure
for i=1:length(SynDataU.name)
    subplot(4,6,i)
   % L=min(length(U.ang{i}),length(U.iEMG{i}));
    %figure
    plot(U(i).tonA{1},U(i).tonE{1}(:,3)./U(i).tonE{1}(:,2))
    
    %xlabel('Angle')
end
suptitle('Control Anter/Trape PowerRatio')

figure
for i=1:length(SynDataU.name)
    subplot(4,6,i)
   % L=min(length(U.ang{i}),length(U.iEMG{i}));
    %figure
    plot(U(i).tonA{1},U(i).tonE{1}(:,5)./U(i).tonE{1}(:,6))
    
    %xlabel('Angle')
end
suptitle('Control Bice/Trice PowerRatio')
end


%% single example
if 0
a=3;
c=5;
figure
%plot(A(i).iEMG{m}(:,2:6))
plot(A(a).tonE{1}(:,2:6))
title('A.iEMG')
legend('2','3','4','5','6')
figure
plot(U(c).tonE{1}(:,2:6))
title('U.iEMG')
legend('2','3','4','5','6')
La=min(length(A(a).ang{2}),length(A(a).iEMG));
figure
plot(A(a).ang{2}(1:La),A(a).iEMG(1:La,3)./A(a).iEMG(1:La,2))
%y=plotfit(A.ang{m}(1:L),A.iEMG{m}(1:L,2));
title('A.syn')
Lc=min(length(U(c).ang{2}),length(U(c).iEMG));
figure
plot(U(c).ang{2}(1:Lc),U(c).iEMG(1:Lc,3)./U(c).iEMG(1:Lc,2))
title('U.syn')

end