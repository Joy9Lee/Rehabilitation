function [Isotonic,Isometric]=Segment(data,loc,varargin)    
% cut the sEMG signals into two segments, isometric and isotonic.

%% reload function
error(nargchk(2,3,nargin));
if nargin ==3 && varargin{1}=='A'
    Display =1;
elseif nargin ==3 && varargin{1}=='U'
    Display =2;
else Display=0;
end

%% Initial variables
N=length(data);     %total number of people 
fs=50;
%% Segment function
for i=1:N
    len=length(data{i});
    temp=loc(i);
    Isotonic{i}=data{i}(1:temp,:);                     %����end
    Isometric{i}=data{i}(temp+1:len,:);               %�ȳ�
end

%% display

if Display==2
    figure
    for i=1:N
        le=length(data{i});
        t1=(0:le-1)/fs;
        subplot(5,2,i)
        plot(t1,data{i})
        hold on
        y=0:0.1:450;
        x=loc(i)/fs;
        plot(x,y,'-k')
        if i==1
         legend('б����','���Ǽ�ǰ��','�Ŷ�ͷ��','����ͷ��')   
        end
      
    end
    
    suptitle('Unaffected')
     
end

if Display==1
    figure
    for i=1:N
        le=length(data{i});
        t1=(0:le-1)/fs;
        subplot(4,4,i)
        plot(t1,data{i})
        hold on
        y=0:0.1:300;
        x=loc(i)/fs;
        plot(x,y,'-k')
        if i==1 
         legend('б����','���Ǽ�ǰ��','�Ŷ�ͷ��','����ͷ��')   
        end
      
    end
    
    suptitle('Affected')
     
end
end
