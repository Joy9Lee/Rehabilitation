clc
close all
clear all
%Cut the each row or column of the input array into two parts, the varying part and the smooth part
%Input data is a MxN array

fs=50;
load('../DATA/dataSetA');
inData=dataSetA;
win=6;
%% IntoPart function

for i=1:length(inData.quat)

    N=size(inData.quat(i).limb{2});
%     for j=1:N(2)
        x(i,1)=LineSec(inData.quat(i).limb{2}(:,1));
%     end
    loc(i)=max(x(i,:));
end

if 1
    figure
    for i=1:length(inData.quat)
        subplot(7,5,i)
        plot(inData.quat(i).limb{2}(:,1));
        hold on;
        plot([loc(i) loc(i)],[0.8 1],'--m');
        grid on;
    end
end