close all
clear all
clc
emg=[24:49];
mvc=[48:73];
r=emg./max(mvc);
r2=emg./mean(mvc)
plot(r)
figure
plot(r2)