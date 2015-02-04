function loc=IntoPart(filePath,data)
% Take the data into two part,varying and smooth 

%% Initial constant
fs=50;
LForder=40;                  %order of lowpass filter
Hd = lowpassfir;
%filePath='G:\SNARC\Rehabilitation\DATA\Unaffected.mat';
load(filePath);
%data=Unaffected;
inData=data;
win=6;
p=0;

%% IntoPart function
for i=1:length(inData)
    figure(i)
    N=length(inData(i).R.flx.kin(1).limb{4});
    t=(1:N)/fs;
    d1=diff(inData(i).R.flx.kin(1).limb{4});
    d11=filter(Hd,d1);
    if mod(LForder,2)==0
        d12=d11(LForder/2+1:end,:);
    else d12=d11((LForder-1)/2+1:end,:);
    end
    thr(i,:)=(max(d12)-min(d12))*0.4;
    t1=(1:N-1)/fs;
    t2=(1:N-2)/fs;
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

%       d2=diff(inData(i).R.flx.kin(1).limb{1},2);
%       d21=filter(Hd,d2);
%       if mod(LForder,2)==0
%           d22=d21(LForder/2:end);
%       else d22=d21((LForder-1)/2:end);
%       end
%       
%       
%       plot(d2)
%        xlim([0 300])
%       hold on
%       grid on;
%       subplot(5,1,5)
%       plot(d22)
%       xlim([0 300])
%       grid on
     
      %
      [a,b]=max(d11);
       
           for j=b:N-1-win       
         
              if all(sum(abs(d11(j:j+win-1,:)))/win-thr(i,:)<0)
              %if sum(abs(d11(j:j+win-1,k)))/win<thr(i,k) && max(inData(i).R.flx.kin(1).limb{3}(:,k))-inData(i).R.flx.kin(1).limb{3}(j+win/2,k)<10
                  x=j+win/2;
                  y=0:0.01:1;
                  subplot(3,1,1)
                 plot(x,y)
                 % xlim([0 300])
                 xlabel('t/s')
                 ylabel('shd angle')
                 hold on
                 loc(i)=x;
                   break
          %sEMG(i).isometric=inData(i).ang.shd.adb(j+win/2+1:N);
          %sEMG(i).isotonic=inData(i).ang.shd.adb(1:j+win/2);
        
              end
          end
             
                      
      
      %}
  %d=diff(synDataA(i).ang.shd.adb)
end
%synDataA(9).loc=200;
%save('synDataU.mat','synDataU');
