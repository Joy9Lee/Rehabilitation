function EMG=EMGPre(data,varargin)
%sEMG signal preprocess function
%   iEMG=SigPre(data) input the raw sEMG signal, and return the preprocessed signal to futuer application.
%   varargin is the reloading argument.
%   Add argument 'd' to display the process.
%	Orignal signal Sampling rate 1KHz.
%	Frist high-pass FIR filter with 50th order, cut of 50Hz .
%	Then rectified.
%	Then low-pass FIR filter with 50th order, cut of 20Hz.
%	Then integrated over 20ms intervals.
%	Finally normalized each channal to unit variance.

% close all;
% clc;
% clear;
%% reload function
error(nargchk(1,2,nargin));
if nargin ==2 && varargin{1}=='d'
    Display = 1;
else
    Display = 0;
end
%% Initialization
muscleName={'�ش�';'б����';'���Ǽ�ǰ��';'���Ǽ�����';'�Ŷ�ͷ��';'����ͷ��';'�����'};
%50Hz high-pass FIR filter design by fdatool
%Initail time sequence 
N=length(data);
fs=1000;
t=(1:N)/fs;
%% Display original signal
if Display
    figure
    for i=1:7
        subplot(7,1,i)
        plot(data(:,i));
        ylim([-1000 1000])
        title(muscleName(i));
    end

    Hw=fft(data,N);

    figure
    for i=1:7
        subplot(7,1,i)    
        plot((0:N-1)*fs/N,abs(Hw(:,i)));% �鿴�ź�Ƶ��
        title('Ƶ��');
        xlabel('Ƶ��/Hz');
        ylabel('���|H(e^jw)|');
        xlim([10 990]);
        %ylim([0 0.6]);
        title(muscleName(i));
    end
end

%% 5-250 bandpass
Hd = bandiir5_250;
%data=filter(Hd,data);
EMG=filter(Hd,data);

if Display
    figure
    for i=1:7
        subplot(7,1,i)
        plot(data(:,i));
        ylim([-1000 1000])
    end
    
    Hw1=fft(data,N);    
    
    figure;
    for i=1:7
        subplot(7,1,i)    
        plot((0:N-1)*fs/N,abs(Hw1(:,i)));% �鿴�ź�Ƶ��
        title('Ƶ��');
        xlabel('Ƶ��/Hz');
        ylabel('���|H(e^jw)|');
        xlim([10 990]);
        %ylim([0 0.6]);
    end
end
%% rectified
%EMG=abs(data);
