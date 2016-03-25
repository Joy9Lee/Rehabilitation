function iEMG=PreProcess_PCA(data,varargin)
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
if nargin ==2 && varargin{1}==1
    Display = 1;
else
    Display = 0;
end
%% Initialization

%50Hz high-pass FIR filter design by fdatool
%20Hz low-pass FIR filter design by fdatool
%Initail time sequence

%% 50Hz high-pass
Hd1= HighFIR50;
data=filter(Hd1,data);
if 0
    figure
    for i=1:7
        subplot(7,1,i)
        plot(data(:,i));
        ylim([-1000 1000])
    end
    
    Hw=fft(data,N);    
    
    figure;
    for i=1:7
        subplot(7,1,i)    
        plot((0:N-1)*fs/N,abs(Hw(:,i)));% 查看信号频谱
        title('频域');
        xlabel('频率/Hz');
        ylabel('振幅|H(e^jw)|');
        xlim([10 990]);
        %ylim([0 0.6]);
    end
end

%% rectified

data=abs(data);
%% 20Hz low-pass
Hd2= LowFIR20;
data=filter(Hd2,data);

%% Integrated over 20-ms intervvals
Tw=20;
L_iEMG=floor(length(data)/Tw)-1;
iEMG=zeros(L_iEMG,7);
for i=1:L_iEMG
    iEMG(i,:)=sum(data(Tw*(i-1)+1:Tw*i,:),1);
end

%% normalization
% for i=1:7
%     max_value=max(iEMG(:,i));
%     min_value=min(iEMG(:,i));
% 
%     iEMG(:,i) = (iEMG(:,i)-min_value) / (max_value-min_value);
% end
iEMG=zscore(iEMG);
if Display
    figure
 for i=1:7
        subplot(7,1,i)
        plot(iEMG(:,i));
        
  end
end
%     figure;
%     for i=1:7
%         subplot(7,1,i);
%         plot(t2,iEMG(:,i));
%         xlabel('时间 s');
%         ylabel('iEMG');
%         %ylim([0 500*Tw]);
%         title(muscleName(i));
%     end
% end
