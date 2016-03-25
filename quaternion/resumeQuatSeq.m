%resumeQuatSeq.m
%resume the order of quaternion, from [w x y z] to [x y z w].
close all
clear all
clc
load('../DATA/SynDataA39_quat');   %loaded data, SynDataA's quaternion is in the order of [w x y z].
load('../DATA/SynDataU25_quat');   %
Kind=0;              % Kind = 1 --> patient; Kind = 0 --> normal person
switch Kind
    case 1
        inData=SynDataA;
    case 0
        inData=SynDataU;
    otherwise
        error('The wrong kind!');
end
for i=1:length(inData.name)
    for j=1:4
        waistTemp = inData.quat(i).limb{j};
        temp(i).limb{j} = [waistTemp(:,2) waistTemp(:,3) waistTemp(:,4) waistTemp(:,1)];          %waist
    end
end
if Kind==1
    DataA=SynDataA;
    DataA.quat=temp';
elseif Kind==0
     DataU=SynDataU;
    DataU.quat=temp';
end
        