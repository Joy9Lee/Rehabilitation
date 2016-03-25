close all
clear all
clc
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');
load('../../DATA/backup/DataA-35');
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
        figure
        %subplot(5,5,i)
        plot(SynDataA.EMG{9}(:,1))
        title(['FM=' num2str(SynDataA.FM(i))]);
        
    end
    
    if 0
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
        plot((0:N-1)*fs/N,abs(Hw1));% 查看信号频谱
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

%% plot one data
 i=4;
 N=length(SynDataA.EMG{i}(:,3));
if 0
        figure
        Hw7=fft(SynDataA.EMG{i}(:,3),N);
        plot(SynDataA.EMG{i}(:,3))
        title(['FM=' num2str(SynDataA.FM(i))]);
        figure
         plot((0:N-1)*fs/N,abs(Hw7));% 查看信号频谱
        
end
if 0
        Hw8=fft(EMG{i}(:,3),N);
        figure
        plot(EMG{i}(:,3))
        title(['FM=' num2str(SynDataA.FM(i))]);
        figure
         plot((0:N-1)*fs/N,abs(Hw8));% 查看信号频谱
end
if 0
figure(1)
suptitle('raw EMG')
figure(2)
suptitle('raw mvc')
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
     N2=length(SynDataU.EMG{i}(:,3));
     HwU=fft(SynDataU.EMG{i}(:,3),N2);
     if 0
        figure(6)
        subplot(5,5,i)
        plot((0:N2-1)*fs/N2,abs(HwU));% 查看信号频谱
        %ylim([0 30])
        %legend('2','3')
    end
    
    
end
if 0 
figure(3)
suptitle('raw EMG')
figure(4)
suptitle('raw mvc')
end
if 0
        figure(3)
        plot(SynDataU.EMG{7}(:,3))
end
if 0
        figure(4)
        plot(SynDataU.mvc{7}(:,3))
end


