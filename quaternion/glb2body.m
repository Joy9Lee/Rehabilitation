clear;
clc;
close all;
load('../DATA/KineA');
load('../DATA/KineU');

% for i=1:length(dataSetA.name)
%     for j=1:4
%         dataSetA.quat(i).limb{2}=quatdivide(dataSetA.quat(i).limb{2},dataSetA.quat(i).limb{1});
%     end    
% end
% 
% for i=1:length(dataSetU.name)
%     for j=1:4
%         dataSetU.quat(i).limb{2}=quatdivide(dataSetU.quat(i).limb{2},dataSetU.quat(i).limb{1});
%     end    
% end

for i=1:length(kineA.name)
    for j=1:4
        kineA.quat(i).limb{5}=quatmultiply(quatinv(kineA.quat(i).limb{1}),kineA.quat(i).limb{2});
        
    end    
end

for i=1:length(kineU.name)
    for j=1:4
        kineU.quat(i).limb{5}=quatmultiply(quatinv(kineU.quat(i).limb{1}),kineU.quat(i).limb{2});
    end    
end