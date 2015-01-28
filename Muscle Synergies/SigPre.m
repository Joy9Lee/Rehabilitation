function iEMG=SigPre(data,varargin)
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
muscleName={'胸大肌';'斜方肌';'三角肌前组';'三角肌中组';'肱二头肌';'肱三头肌';'肱桡机'};
%50Hz high-pass FIR filter design by fdatool
b1=[-0.0320686949081382,-0.00670619615255431,-0.00606575856965294,-0.00444729513086394,-0.00185155570653111,0.00156677904258902,0.00558834451237082,0.00984714509154782,0.0139470979716452,0.0173821603717888,0.0196891798880309,0.0203787495412441,0.0190935258172264,0.0155586471762754,0.00960397515054329,0.00135033815394213,-0.00902094169544538,-0.0211177005245033,-0.0343514285770585,-0.0480328369541495,-0.0613997558978118,-0.0736917937570919,-0.0841532487834629,-0.0921445637505135,-0.0971554902683885,0.901134744605631,-0.0971554902683885,-0.0921445637505135,-0.0841532487834629,-0.0736917937570919,-0.0613997558978118,-0.0480328369541495,-0.0343514285770585,-0.0211177005245033,-0.00902094169544538,0.00135033815394213,0.00960397515054329,0.0155586471762754,0.0190935258172264,0.0203787495412441,0.0196891798880309,0.0173821603717888,0.0139470979716452,0.00984714509154782,0.00558834451237082,0.00156677904258902,-0.00185155570653111,-0.00444729513086394,-0.00606575856965294,-0.00670619615255431,-0.0320686949081382];
%20Hz low-pass FIR filter design by fdatool
b2=[-0.172538994739611,0.0163579113512634,0.0161664502327808,0.0163421809317387,0.0168503854670782,0.0176731743718614,0.0188013266588980,0.0201962470207465,0.0217733779162191,0.0232257585650698,0.0251704446421775,0.0270202114459591,0.0289489538051396,0.0308857203278344,0.0327906030788306,0.0346617501357084,0.0364610644537297,0.0381670467165413,0.0396728519890217,0.0410946386758429,0.0423004825901262,0.0433235173116583,0.0441394379137073,0.0447131416923227,0.0450799915377216,0.0451909242720373,0.0450799915377216,0.0447131416923227,0.0441394379137073,0.0433235173116583,0.0423004825901262,0.0410946386758429,0.0396728519890217,0.0381670467165413,0.0364610644537297,0.0346617501357084,0.0327906030788306,0.0308857203278344,0.0289489538051396,0.0270202114459591,0.0251704446421775,0.0232257585650698,0.0217733779162191,0.0201962470207465,0.0188013266588980,0.0176731743718614,0.0168503854670782,0.0163421809317387,0.0161664502327808,0.0163579113512634,-0.172538994739611];
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
        plot((0:N-1)*fs/N,abs(Hw(:,i)));% 查看信号频谱
        title('频域');
        xlabel('频率/Hz');
        ylabel('振幅|H(e^jw)|');
        xlim([10 990]);
        %ylim([0 0.6]);
        title(muscleName(i));
    end
end

%% 50Hz high-pass
data=filter(b1,1,data);

if Display
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
data=filter(b2,1,data);
if Display
    figure;
    for i=1:7
        subplot(7,1,i)
        plot(t,data(:,i));
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
%% Integrated over 20-ms intervvals
Tw=20;
L_iEMG=floor(length(data)/Tw)-1;
iEMG=zeros(L_iEMG,7);
for i=1:L_iEMG
    iEMG(i,:)=sum(data(Tw*i:Tw*i+Tw,:),1);
end
%draw iEMG
t2=(1:L_iEMG)/(fs/Tw);
if Display
    figure;
    for i=1:7
        subplot(7,1,i);
        plot(t2,iEMG(:,i));
        xlabel('时间 s');
        ylabel('iEMG');
        %ylim([0 500*Tw]);
        title(muscleName(i));
    end
end
%% normalization
iEMG=mapminmax(iEMG',0,1)';
% for i=1:7
%     data(:,i)=mapminmax(data(:,i)',0,1)';
% end
if Display
    figure;
    for i=1:7
        subplot(7,1,i);
        plot(t2,iEMG(:,i));
        xlabel('时间 s');
        ylabel('iEMG');
        %ylim([0 500*Tw]);
        title(muscleName(i));
    end
end
