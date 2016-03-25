close all;
clear;
clc;
%%
load('../DATA/kineA');
%<<<<<<< HEAD:quaternion/main.m
load('../DATA/kineU');
PART = 2;
%% glb2body 
PART = 2;
% for i=1:length(kineA.name)
%     for j=1:4
% %         kineA.quat(i).limb{2}=quatdivide(kineA.quat(i).limb{1},kineA.quat(i).limb{2});
%         kineA.quat(i).limb{2}=quatmultiply(quatinv(kineA.quat(i).limb{1}),kineA.quat(i).limb{2});
%=======
load('../DATA/kineUA');
load('../DATA/kineU');
PART = 3;
%% glb2body 
% PART = 2;
% for i=1:length(kineA.name)
%     for j=1:4
% %         kineA.quat(i).limb{2}=quatdivide(kineA.quat(i).limb{1},kineA.quat(i).limb{2});
%         kineA.quat(i).limb{2}=quatmultiply(quatinv(kineA.quat(i).limb{1}),(kineA.quat(i).limb{2}));
%>>>>>>> 71d8a58c36b86ee2c88f4c01568b9b60eeb6eca4:quaternion/main.m
%     end    
% end
% 
% for i=1:length(kineU.name)
%     for j=1:4
% %         kineU.quat(i).limb{2}=quatdivide(kineU.quat(i).limb{1},kineU.quat(i).limb{2});
%<<<<<<< HEAD:quaternion/main.m
%         kineU.quat(i).limb{2}=quatmultiply(quatinv(kineU.quat(i).limb{1}),kineU.quat(i).limb{2});
%=======
%         kineA.quat(i).limb{2}=quatmultiply(quatinv(kineA.quat(i).limb{1}),(kineA.quat(i).limb{2}));
%>>>>>>> 71d8a58c36b86ee2c88f4c01568b9b60eeb6eca4:quaternion/main.m
%     end    
% end
%%
for i=1:length(kineA.name)
    if ~isempty(kineA.quat(i).limb)
        for j=1:4
            [A(i).angA{j} A(i).axisA{j}]=quatfac(kineA.quat(i).limb{j});
        end    
        Sh.A.ang.ton{i}=A(i).angA{PART}(kineA.loc0(i) : kineA.loc1(i));
        Sh.A.ang.met{i}=A(i).angA{PART}(kineA.loc1(i) : end);
        Sh.A.axis.ton{i}=A(i).axisA{PART}(kineA.loc0(i) : kineA.loc1(i),:);
        Sh.A.axis.met{i}=A(i).axisA{PART}(kineA.loc1(i) : end,:);
        
        Tru.A{i} = A(i).angA{1};
    end
end

Sh.A.FM = kineA.FM';

for i=1:length(kineU.name)
    for j=1:4
        [U(i).angU{j} U(i).axisU{j}]=quatfac(kineU.quat(i).limb{j});

    end
    Sh.U.ang.ton{i}=U(i).angU{PART}(kineU.loc0(i) : kineU.loc1(i));
    Sh.U.ang.met{i}=U(i).angU{PART}(kineU.loc1(i) : end);
    Sh.U.axis.ton{i}=U(i).axisU{PART}(kineU.loc0(i) : kineU.loc1(i),:);
    Sh.U.axis.met{i}=U(i).axisU{PART}(kineU.loc1(i) : end,:);
    
    Tru.U{i} = U(i).angU{1};
end



figure;
for i=1:length(kineA.name)
    if ~isempty(kineA.quat(i).limb)
        subplot(5,7,i)
        plot(A(i).angA{PART}/90);
        hold on;
        plot([kineA.loc1(i) kineA.loc1(i)],[0 1],'--m');
        plot([kineA.loc0(i) kineA.loc0(i)],[0 1],'--k');
        ylim([0 1]);
    end   
    title(['FM=' num2str(kineA.FM(i))]);
end

figure;
for i=1:length(kineA.name)
    if ~isempty(kineA.quat(i).limb)
        subplot(5,7,i)
        plot(A(i).axisA{PART});
        hold on;
        plot([kineA.loc1(i) kineA.loc1(i)],[-1 1],'--m');
        plot([kineA.loc0(i) kineA.loc0(i)],[-1 1],'--k');
        ylim([-1 1]);
    end
    title(['FM=' num2str(kineA.FM(i))]);
end


figure;
for i=1:length(kineU.name)
    subplot(4,3,i)
    plot(U(i).angU{PART}/90);
    hold on;
    plot([kineU.loc1(i) kineU.loc1(i)],[0 1],'--m');
    plot([kineU.loc0(i) kineU.loc0(i)],[0 1],'--k');
    ylim([0 1]);
end

figure;
for i=1:length(kineU.name)
    subplot(4,3,i)
    plot(U(i).axisU{PART});
    hold on;
    plot([kineU.loc1(i) kineU.loc1(i)],[-1 1],'--m');
    plot([kineU.loc0(i) kineU.loc0(i)],[-1 1],'--k');
    ylim([-1 1]);
end    

figure;
for i=1:length(kineA.name)
    subplot(5,7,i)
    plot(Tru.A{i}/90);
    ylim([0 1]);
end

figure;
for i=1:length(kineU.name)
    subplot(4,3,i)
    plot(Tru.U{i}/90);
    ylim([0 1]);
end

% Name={'Ñü','´ó±Û','Ð¡±Û','ÊÖ'}
% for i=1:4
%     figure('Name', Name{i});
%     text(0,0,Name(i));
%     subplot(2,2,1)
%     plot(scaleA{i});
%     title('»¼ÕßÐý×ª½Ç');
%     subplot(2,2,3)
%     plot(scaleU{i});
%     title('½¡¿µÐý×ªÖá');
%     subplot(2,2,2)
%     plot(axisA{i});
%     title('»¼ÕßÐý×ª½Ç');
%     subplot(2,2,4)
%     plot(axisU{i});
%     title('½¡¿µÐý×ªÖá');
%     
% end

