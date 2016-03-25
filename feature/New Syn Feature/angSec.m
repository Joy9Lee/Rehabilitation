%Cut the each row or column of the input array into two parts, the varying part and the smooth part
%Input data is a MxN array
close all; clear ; clc;
load('../../DATA/SynDataA_39');
load('../../DATA/SynDataU_25');
addpath('../../SignalProcess');
addpath('../../feature')
fs=50;
%%find loc
for i=1:length(SynDataA.name)

    locA(i)=LineSec(SynDataA.shdAng{i});  
     if (i~=22) && (i~=29) &&( i~=30) && (i~=31)
        locAU(i)=LineSec(SynDataA.shdAngU{i});  
     end
end
for i=1:length(SynDataU.name)
    
    locH(i)=LineSec(SynDataU.shdAngR{i});
end
for i=1:length(SynDataU.name)
    figure
    if i~=1 && (i~=3)
        
        locHL(i)=LineSec(SynDataU.shdAngL{i},'d');
    end
end