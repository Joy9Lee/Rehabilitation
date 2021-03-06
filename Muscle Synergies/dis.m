clc;
clear;
close all
x1= [0.8300    0.8600    0.8000    0.7800    0.7400  0.7400	0.7300    0.9200    0.9700    0.9900];
y1 = [ 37    19    48    16    51    57    12    28    63    56];
x2 = [0.93 0.92 0.94 0.96 0.91];
y2 = [65    65  65   65   65];
h1=plot(x1,y1,'*'); 
hold on;
h2=plot(x2,y2,'og'); 
title('肌肉协同组数 N=3');
xlabel('肌肉协同相似度');
ylabel('Fugl-Meyer Score');
legend([h1,h2],'患者','常人',2);

[h,sig,ci]=ttest2(x1,x2);