function SpeRatio=Smoothness(data,cutoff,varargin)    
% calculate the ratio of frequency lower than cutoff to the whole in the spcturm 


%% reload function
error(nargchk(2,3,nargin));

if nargin ==3 && varargin{1}=='d'
    Display = 1;
else
    Display = 0;
end

%% Initial variables
N=length(data);     %total number of people 
fs=50;
%% smoothness function
for i=1:N
    inData=data{i};
    l=length(inData);
    d=diff(inData);
    pos=round(cutoff*l/fs)+2;
    t=(1:l-1)/fs;
    f=(0:l-2)*fs/(l-1);
    Hw=abs(fft(d,l-1));
    SpeRatio(i)=sum(Hw(1:pos))/(sum(Hw)/2);                    %µÍÆµÕ¼ÆµÆ×±È
%% Display
    if Display
        figure
        subplot(2,1,1)
        plot(t,d)
        subplot(2,1,2)
        plot(f,Hw);             % ²é¿´ÐÅºÅÆµÆ×
        title('ÆµÓò');
        xlabel('ÆµÂÊ/Hz');
        ylabel('Õñ·ù|H(e^jw)|');  
    end
end

end
