close all
clear all
clc
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');
addpath('../../signalProcess')

fs=1000;

for i=1:length(SynDataA.EMG)
    m1(i)=max(abs(SynDataA.EMG{i}(:,3)));
    m2(i)=max(abs(SynDataA.mvc{i}(:,3)));
    N=length(SynDataA.EMG{i}(:,3));
    t=(1:N)/fs;  
    EMG{i}=EMGPre(SynDataA.EMG{i});
    mvc{i}=EMGPre(SynDataA.mvc{i});
    m3(i)=max(abs(EMG{i}(:,3)));
    m4(i)=max(abs(mvc{i}(:,3)));
    Hw1=fft(SynDataA.EMG{i}(:,3),N);
%% plot time domain of raw EMG and mvc
    if 1
        figure(1)
        subplot(5,5,i)
        plot(SynDataA.EMG{i}(:,3))
        title(['FM=' num2str(SynDataA.FM(i))]);
    end
    if 1
        figure(2)
        subplot(5,5,i)
        plot(SynDataA.mvc{i}(:,3))
        title(['FM=' num2str(SynDataA.FM(i))]);
        
        
        %ylim([0 30])
        %legend('2','3')
    end
%% plot time domain of EMG before and after EMGPre
    if 0
    figure(7)
    subplot(2,1,1)
    plot(SynDataA.EMG{i}(:,3));
    subplot(2,1,2)
    plot(EMG{i}(:,3))
    end

%% plot spectrum of EMG for each person      
     if 0
        figure(5)
        subplot(5,5,i)
        plot((0:N-1)*fs/N,abs(Hw1));% ²é¿´ÐÅºÅÆµÆ×
        %ylim([0 30])
        %legend('2','3')
    end
    
    
    %% plot spectrum before and after EMGPre
     if 0
        figure(6)
        subplot(2,1,1)
        plot((0:N-1)*fs/N,abs(Hw1));
        subplot(2,1,2)
        %subplot(4,5,i)
        Hw3=fft(EMG{i},N);
        plot((0:N-1)*fs/N,abs(Hw3));
        title(['FM=' num2str(SynDataA.FM(i))]);
        
     end
  
end
for i=1:length(SynDataU.EMG)
     %m3(i)=max(abs(SynDataU.EMG{i}(:,3)));
     %m4(i)=max(abs(SynDataU.mvc{i}(:,3)));
     if 0
        figure(3)
        subplot(5,5,i)
        plot(SynDataU.EMG{i}(:,3))
        
        %ylim([0 30])
        %legend('2','3')
        %legend('3','4','5')
     end
     if 0
        figure(4)
        subplot(5,5,i)
        plot(SynDataU.mvc{i}(:,3))
       
        
        %ylim([0 30])
        %legend('2','3')
        %legend('2','3','4','5')
    end
end