close all; clear; clc;
a=rand(20,2);
figure
for i=1:length(a)
    plot(a(i,1),a(i,2),'ro')
    hold on
end