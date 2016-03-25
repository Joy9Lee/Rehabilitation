function loc=LineSec(data,varargin)
%Cut the data of a line into two parts, the varying part and the smooth
%part, isometric and isotonic.
%Input data is a 1xN array

% filePath='G:\SNARC\Rehabilitation\DATA\newDataU.mat';
% load(filePath);
% data=newDataU(3).R.flx.kin(1).limb{4}(:,1)';
%% reload function
error(nargchk(1,2,nargin));
if nargin ==2 && varargin{1}=='d'
    Display = 1;
else
    Display = 0;
end

%% Initial constant
LForder=40;                  %order of the lowpass filter
Hd = lowpassfir;             %LowPass filter fs=50Hz
WIN=10;                       %time window  
N=length(data);
x=0;
y=0;
%% Section function
d1=diff(data);
d11=filter(Hd,d1);

if mod(LForder,2)==0
    d12=d11(LForder/2+1:end);
else
    d12=d11((LForder-1)/2+1:end);
end
% thr=(max(d12)-min(d12))*0.35;
thr = mean(abs(d12))*0.8;
[a,index]=max(abs(d12));
% index=find(data>max(data))
for j=index:N-1-WIN-LForder/2 
    if sum(abs(d12(j:j+WIN-1)))/WIN<thr
        x=j+WIN/2;
        y=0:0.05:max(data);
        break
    end
end
loc=x;
%% Display
if Display
    
subplot(3,1,1)
    plot(data)
    hold on;
    plot([loc loc],[min(data),max(data)],'--m');
    
    plot(x,y,'c');
    subplot(3,1,2)
    plot(d1);
    hold on;
    plot([loc loc],[min(d1),max(d1)],'--m');
    subplot(3,1,3)
    plot(d12)
    hold on;
    plot([loc loc],[min(d12),max(d12)],'--m');
    hold off;
end