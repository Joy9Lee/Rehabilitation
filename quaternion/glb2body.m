clear;
clc;
close all;
load('../../DATA/unaffected');
load('../../DATA/affected');

for i=2:length(dataSetA.name)
    for j=1:4
        dataSetA.quat(i).limb{j}=dataSetA.quat(i).limb{j}(dataSetA.quat(i).limb{j},dataSetA.quat(i).limb{j});
    end    
end