clear;
clc;
close all;
load('../DATA/dataSetA');
load('../DATA/dataSetU');

for i=1:length(dataSetA.name)
    for j=1:4
        dataSetA.quat(i).limb{2}=quatdivide(dataSetA.quat(i).limb{2},dataSetA.quat(i).limb{1});
    end    
end

for i=1:length(dataSetU.name)
    for j=1:4
        dataSetU.quat(i).limb{2}=quatdivide(dataSetU.quat(i).limb{2},dataSetU.quat(i).limb{1});
    end    
end