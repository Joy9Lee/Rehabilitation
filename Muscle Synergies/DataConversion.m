%%数据转换

close all;
clc;
clear;

B1=[0.9492         0         0         0         0         0         0         0         0         0         0         0         0         0         0         0         0         0         0         0   -0.9492];
A1=[ 1.0000         0         0         0         0         0         0         0         0         0         0         0         0         0         0         0         0         0         0         0   -0.8985];

A2 = [1.0000   -1.8987    0.9965];
B2 = [0.9982   -1.8987    0.9982];

B3 = [0.9596   -3.1067    4.4337   -3.1067    0.9596 ];
A3 = [ 1.0000   -3.1709    4.4321   -3.0426    0.9207];
    
a=textread('RawData.txt','%s')';
b=hex2dec(a)';
n=2;
    d=zeros(1,length(b)*20/331);
    c=zeros(1,331);
    for i=0:(length(b)/331)-1
        c=b(i*331+1:i*331+331);
        for j=0:19
            d(i*20+j+1)=c(12+16*j+n*4)*256*256+c(13+16*j+n*4)*256+c(14+16*j+n*4);
        end
    end


%%
%{
c=zeros(1,length(b)/8);
for k=1:length(b)/8
    c(k)=b(8*k-7)*256*256+b(8*k-6)*256+b(8*k-5);
   %  c(k)=b(8*k-3)*256*256+b(8*k-2)*256+b(8*k-1);
   % c(k)=b(4*k-3)*256*256+b(4*k-2)*256+b(4*k-1);
end
%}
%%补码转源码
l=zeros(1,length(d));
for k=1:length(d)
    l(k)=conv(d(k));
end



N=length(l);
l1=l(1:N);
%%显示
fs=1000;
N=length(l1);
t=(1:N)/fs;
Hw=fft(l1,N);




subplot(2,1,1);
plot(t,l1);
title('时域');
xlabel('时间/s');% 原始信号
ylabel('1');
%ylim([-0.095 0.-0.075]);

subplot(2,1,2);
plot((0:N-1)*fs/N,abs(Hw));% 查看信号频谱
title('频域');
xlabel('频率/Hz');
ylabel('振幅|H(e^jw)|');
xlim([10 990]);
%ylim([0 0.6]);


 %l=filter(B2,A2,l);
 %N=length(l);
 %l=l(200:N);

%//////////////////////////////////////////////////////////////
l=filter(B1,A1,l);
N=length(l);
l=l(1000:N);

fs=1000;
N=length(l);
t=(1:N)/fs;
Hw=fft(l,N);


figure(2);
subplot(2,1,1);
plot(t,l);
title('时域');
xlabel('时间/s');% 原始信号
ylabel('2');

subplot(2,1,2);
plot((0:N-1)*fs/N,abs(Hw));% 查看信号频谱
title('频域');
xlabel('频率/Hz');
ylabel('振幅|H(e^jw)|');
xlim([10 990]);
%ylim([0 0.6]);


