function DisplayEMG(data)
%View the signals in figures
figure(1);

N=length(data);
fs=1000;
t=(1:N)/fs;

for i=1:7
    subplot(7,1,i)
    plot(data(:,i));
    ylim([-1000 1000])
end

Hw=fft(data,N);

figure(2);
for i=1:7
    subplot(7,1,i)    
    plot((0:N-1)*fs/N,abs(Hw(:,i)));% ²é¿´ÐÅºÅÆµÆ×
    title('ÆµÓò');
    xlabel('ÆµÂÊ/Hz');
    ylabel('Õñ·ù|H(e^jw)|');
    xlim([10 990]);
    %ylim([0 0.6]);
end