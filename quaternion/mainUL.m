close all;
clear;
clc;
%%
load('../DATA/SynDataA39_quat');

load('../DATA/SynDataU25_quat');
PART = 3;
kineA=SynDataA;
kineU=SynDataU;

%%
for i=1:length(kineA.name)
    if ~isempty(kineA.quatL(i).limb)
        for j=1:4
            [A(i).angA{j} A(i).axisA{j}]=quatfac(kineA.quatL(i).limb{j});
        end    
        Sh.A.ang.ton{i}=A(i).angA{PART}(kineA.loc0l(i) : kineA.loc1l(i));
        Sh.A.ang.met{i}=A(i).angA{PART}(kineA.loc1l(i) : end);
        Sh.A.axis.ton{i}=A(i).axisA{PART}(kineA.loc0l(i) : kineA.loc1l(i),:);
        Sh.A.axis.met{i}=A(i).axisA{PART}(kineA.loc1l(i) : end,:);
        
        Tru.A{i} = A(i).angA{1};
    end
end

Sh.A.FM = kineA.FM';

for i=1:length(kineU.name)
   if ~isempty(kineU.quatL(i).limb)
    for j=1:4
        [U(i).angU{j} U(i).axisU{j}]=quatfac(kineU.quatL(i).limb{j});

    end
    Sh.U.ang.ton{i}=U(i).angU{PART}(kineU.loc0l(i) : kineU.loc1l(i));
    Sh.U.ang.met{i}=U(i).angU{PART}(kineU.loc1l(i) : end);
    Sh.U.axis.ton{i}=U(i).axisU{PART}(kineU.loc0l(i) : kineU.loc1l(i),:);
    Sh.U.axis.met{i}=U(i).axisU{PART}(kineU.loc1l(i) : end,:);
    
    Tru.U{i} = U(i).angU{1};
   end
end



figure;
for i=1:length(kineA.name)
    if ~isempty(kineA.quatL(i).limb)
        subplot(5,8,i)
        plot(A(i).angA{PART}/90);
        hold on;
        plot([kineA.loc1l(i) kineA.loc1l(i)],[0 1],'--m');
        plot([kineA.loc0l(i) kineA.loc0l(i)],[0 1],'--k');
        ylim([0 1]);
    end   
    title(['FM=' num2str(kineA.FM(i))]);
end

figure;
for i=1:length(kineA.name)
    if ~isempty(kineA.quatL(i).limb)
        subplot(5,8,i)
        plot(A(i).axisA{PART});
        hold on;
        plot([kineA.loc1l(i) kineA.loc1l(i)],[-1 1],'--m');
        plot([kineA.loc0l(i) kineA.loc0l(i)],[-1 1],'--k');
        ylim([-1 1]);
    end
    title(['FM=' num2str(kineA.FM(i))]);
end


figure;
for i=1:length(kineU.name)
     if ~isempty(kineU.quatL(i).limb)
    subplot(5,5,i)
    plot(U(i).angU{PART}/90);
    hold on;
    plot([kineU.loc1l(i) kineU.loc1l(i)],[0 1],'--m');
    plot([kineU.loc0l(i) kineU.loc0l(i)],[0 1],'--k');
    ylim([0 1]);
     end
end

figure;
for i=1:length(kineU.name)
     if ~isempty(kineU.quatL(i).limb)
    subplot(5,5,i)
    plot(U(i).axisU{PART});
    hold on;
    plot([kineU.loc1l(i) kineU.loc1l(i)],[-1 1],'--m');
    plot([kineU.loc0l(i) kineU.loc0l(i)],[-1 1],'--k');
    ylim([-1 1]);
     end
end    

figure;
for i=1:length(kineA.name)
    subplot(5,8,i)
    plot(Tru.A{i}/90);
    ylim([0 1]);
end

figure;
for i=1:length(kineU.name)
    subplot(5,5,i)
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

