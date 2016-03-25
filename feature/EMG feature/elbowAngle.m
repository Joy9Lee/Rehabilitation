clear;
clc;
close all;
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');

for i=1:length(SynDataA.name)
    for j=1:4
     SynDataA.quat(i).limb{5}=quatmultiply(quatinv(SynDataA.quat(i).limb{3}),SynDataA.quat(i).limb{2});
    end    
end

for i=1:length(SynDataU.name)
    for j=1:4
        SynDataU.quat(i).limb{5}=quatmultiply(quatinv(SynDataU.quat(i).limb{3}),SynDataU.quat(i).limb{2});
    end    
end