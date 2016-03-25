close all; clear all; clc;
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');
addpath('../../SignalProcess');
id1=[4 5];          %董景乐
id2=[6 7 8];        %谷维民
id3=[10 11];        %焦占栓
%angA=jointAng(SynDataA,7,0);
angA=jointAng(SynDataA,1,0);
ang1=angA(id1);
ang2=angA(id2);
ang3=angA(id3);
ang=ang2;
figure
for i=1:length(ang)
    [acTime{i},acSeq{i},X{i}]=ActSeq(SynDataA.EMG{i});
    switch i
        case 1 
            plot(ang{1},'r')
            hold on;
        case 2 
            plot(ang{2},'b')
            hold on;
        case 3 
            plot(ang{3},'g')
    end
end
legend('1st','2nd','3rd')
ylabel('Elbow Angle')
title('谷维民三次肘关节角')
