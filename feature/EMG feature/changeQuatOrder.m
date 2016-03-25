% changeQuatOrder.m
% change the order of quat from [x y z w] to [w x y z], where e is the scalar  
%function quat= changeQuatOrder(upperArmQuat,forearmQuat,wristQuat,flag,method)
clc;    clear;    close all;
load('../../DATA/SynDataA');
load('../../DATA/SynDataU');

for i=1:length(SynDataA.name)
    for j=1:4
        SynDataA.quat(i).limb{j}=[SynDataA.quat(i).limb{j}(:,2) SynDataA.quat(i).limb{j}(:,3) SynDataA.quat(i).limb{j}(:,4) SynDataA.quat(i).limb{j}(:,1)];
    end
end
for i=1:length(SynDataU.name)
    for j=1:4
        SynDataU.quat(i).limb{j}=[SynDataU.quat(i).limb{j}(:,2) SynDataU.quat(i).limb{j}(:,3) SynDataU.quat(i).limb{j}(:,4) SynDataU.quat(i).limb{j}(:,1)];
    end
end