%calculating the iEMG
function iEMG=CiEMG(EMG,Tw) 
Display=0;
N=size(EMG,2);
%EMG=dlmread('hj-motionR1-1.ASC','%d',']');
muscleName={'�ش�';'б����';'���Ǽ�ǰ��';'���Ǽ�����';'�Ŷ�ͷ��';'����ͷ��';'�����'};
freq=1000;                       %sample rate
t=(1:length(EMG))/freq;          %time axis
%Tw=100;                          %time window

%draw the raw data
if Display
    figure;
    for i=1:N
        subplot(N,1,i);
        plot(t,EMG(:,i));
        ylim([-1000 1000]);
        xlabel('ʱ�� s');
        ylabel('��ֵ uV');
        title(muscleName(i));
    end
end

EMG=abs(EMG);
L_iEMG=floor(length(EMG)/Tw)-1;
iEMG=zeros(L_iEMG,N);
for i=1:L_iEMG
    iEMG(i,:)=sum(EMG(Tw*i:Tw*i+Tw,:),1);
end
%draw iEMG
t2=(1:L_iEMG)/(freq/Tw);

if Display
    figure;
    for i=1:N
        subplot(N,1,i);
        plot(t2,iEMG(:,i));
        xlabel('ʱ�� s');
        ylabel('iEMG');
        ylim([0 500*Tw]);
        title(muscleName(i));
    end
end