%% In this m file, plot the rising part of raise ratio and shouder angle.
close all
clear all
clc
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');

addpath('../../quaternion')
addpath('../../SignalProcess')
addpath('../../feature')
fs=50;
%% sort the data according to the FM value
[temp,index] = sort(SynDataA.FM);
SynData1A.name=SynDataA.name(index);
SynData1A.FM=SynDataA.FM(index);
SynData1A.quat=SynDataA.quat(index);
%SynData1A.quatU=SynDataA.quatU(index);
SynData1A.EMG=SynDataA.EMG(index);
%SynData1A.EMGU=SynDataA.EMGU(index);
SynData1A.ratioA=SynDataA.ratioA(index);
%SynData1A.ratioU=SynDataA.ratioU(index);

%% Save the rising part
for i=1:length(SynDataA.EMG)
    SynDataA.r1{i}=SynDataA.ratioA{i}(1:SynDataA.loc(i),:);
    angA{i}=quatfac(SynDataA.quat(i).limb{2});                      %calculate angle
    rtimeA(i)=SynDataA.loc(i)/length(SynDataA.ratioA{i});
    SynDataA.a{i}=CiEMG(SynDataA.r1{i},5);
end
angA=angA';
SynDataA.r1=SynDataA.r1';
for i=1:length(SynDataU.EMG)
    SynDataU.r1{i}=SynDataU.ratio{i}(1:SynDataU.loc(i),:);
    angU{i}=quatfac(SynDataU.quat(i).limb{2});
    rtimeU(i)=SynDataU.loc(i)/length(SynDataU.ratio{i});
     SynDataU.a{i}=CiEMG(SynDataU.r1{i},5);
end

SynDataU.r1=SynDataU.r1';
SynData1A.r1=SynDataA.r1(index);
angU=angU';
%% plot the rising part with time
if 0
    for i=1:length(SynDataA.EMG)

        figure(1)
        subplot(5,5,i)
        plot(SynDataA.r1{i}(:,3))
        title(['FM=' num2str(SynDataA.FM(i))]);
        ylim([0 20])
        xlim([0 300])
        if i==1 
            legend('3')
        end

    end
    for i=1:length(SynDataU.EMG)

        figure(2)
        subplot(5,5,i)
        plot(SynDataU.r1{i}(:,3))
        ylim([0 20])
        xlim([0 300])
        if i==1 
            legend('3')
        end

        %legend('2','3','4','5')
    end
end


%% plot the rising part with angle

if 0
    for i=1:length(SynDataA.EMG)

        figure(1)
        subplot(5,5,i)
        plot(angA{i}(1:SynDataA.loc(i)),SynDataA.r1{i}(:,3));
        title(['FM=' num2str(SynDataA.FM(i))]);
        xlim([0 80])
        ylim([0 20])
        if i==1 
            legend('3')
        end

    end
    for i=1:length(SynDataU.EMG)

        figure(2)
        subplot(5,5,i)
        plot(angU{i}(1:SynDataU.loc(i)),SynDataU.r1{i}(:,3));
        xlim([0 80])
        ylim([0 20])
        if i==1 
            legend('3')
        end

        %legend('2','3','4','5')
    end
end


if 1
    for i=1:length(SynDataA.EMG)

        figure(1)
        subplot(5,5,i)
        plot(angA{i}(1:5:SynDataA.loc(i)),SynDataA.a{i}(:,3));
        title(['FM=' num2str(SynDataA.FM(i))]);
        xlim([0 80])
        ylim([0 20])
        if i==1 
            legend('3')
        end

    end
    for i=1:length(SynDataU.EMG)

        figure(2)
        subplot(5,5,i)
        plot(angU{i}(1:5:SynDataU.loc(i)),SynDataU.a{i}(:,3));
        xlim([0 80])
        ylim([0 20])
        if i==1 
            legend('3')
        end

        %legend('2','3','4','5')
    end
end
%% rising time ratio
%[Mdata,Sdata,p] = diffAnaly2(rtimeA,'Affect',rtimeU,'Unaffect','等张阶段持续时间比例',1);