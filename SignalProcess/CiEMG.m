%calculating the iEMG
function iEMG=CiEMG(EMG,Tw,varargin)      %Tw time window,  n is figure window name
error(nargchk(2,3,nargin));
if nargin ==3 && varargin{1}==d
    Display = 1;
else
    Display = 0;
end


%EMG=dlmread('hj-motionR1-1.ASC','%d',']');
muscleName={'胸大肌';'斜方肌';'三角肌前组';'三角肌中组';'肱二头肌';'肱三头肌';'肱桡机'};
freq=1000;                       %sample rate
t=(1:length(EMG))/freq;          %time axis

%draw the raw data
if Display
    figure(2*n-1);
    for i=1:7
        subplot(7,1,i);
        plot(t,EMG(:,i));
        ylim([-1000 1000]);
        xlabel('时间 s');
        ylabel('幅值 uV');
        title(muscleName(i));
    end
end

EMG=abs(EMG);
L_iEMG=floor(length(EMG)/Tw)-1;
iEMG=zeros(L_iEMG,7);
for i=1:L_iEMG
    iEMG(i,:)=sum(EMG(Tw*(i-1)+1:Tw*i,:),1);
end
%draw iEMG
t2=(1:L_iEMG)/(freq/Tw);

if Display
    figure
    for i=1:7
        subplot(7,1,i);
        plot(t2,iEMG(:,i));
        xlabel('时间 s');
        ylabel('iEMG');
        ylim([0 500*Tw]);
        title(muscleName(i));
    end
end