function loc=IntoPart(filePath,data)
% Take the data into two part,varying and smooth 

%% Initial constant
fs=50;
LForder=40;                  %order of lowpass filter
Hd = lowpassfir;
%filePath='G:\SNARC\Rehabilitation\DATA\newDataU.mat';
load(filePath);
%data=newDataU;
inData=data;
win=6;
%% IntoPart function
for i=1:length(inData)
    figure(i)
    if isfield(inData(i).R,'flx')
        if isfield(inData(i).R.flx,'kin')
            N=length(inData(i).R.flx.kin(1).limb{4});
            t=(1:N)/fs;
            d1=diff(inData(i).R.flx.kin(1).limb{4});
            d11=filter(Hd,d1);
            if mod(LForder,2)==0
                d12=d11(LForder/2+1:end,:);
            else d12=d11((LForder-1)/2+1:end,:);
            end
            thr(i,:)=(max(d12)-min(d12))*0.5;
            subplot(3,1,1)
            plot(inData(i).R.flx.kin(1).limb{4})
            hold on
            grid on;
            %xlim([0 300])

            subplot(3,1,2)
            plot(d1)
            %xlim([0 300])
            %hold on
            grid on;
            subplot(3,1,3)
            plot(d12)
            %xlim([0 300])
            grid on
            [a,b]=max(abs(d12));
            for j=b:N-1-win-LForder/2 
                if all(sum(abs(d12(j:j+win-1,:)))/win-thr(i,:)<0)
                  x=j+win/2;
                  y=0:0.005:1;
                  subplot(3,1,1)
                  plot(x,y,'y')
                  hold on
                  loc(i)=x;
                  break
              
                end
            end
        end
    end
end
