function quat = loadQuat(path,index)
%loadQuat is used to collect the segmented quaternion from quad files 
%Quad3.txt, Quad13.txt, Quad14.txt, Quad15.txt. And returen the organized data. 
%   path is the directory of quaternions files.
%   index is the segment maker.
%   quat is organized quaternions data. q0 place the scale. 
%   qiat{i}.limb(j) indicate the section of the motion, and j indicate the
%   limb. 1=waist 2=arm 3=forearm 4=hand.
%% load original data and resmap the quaternion place scale in q0
path='G:\SNARC\DATA\患者组\白竹彩\右手\运动\1-2013-5-23 10-37-6\';
index=[287;591];
waistTemp = importdata([path 'Quad3.txt']);
temp.limb{1} = [waistTemp(:,4) waistTemp(:,1) waistTemp(:,2) waistTemp(:,3)];          %waist
armTemp = importdata([path 'Quad13.txt']);
temp.limb{2} = [armTemp(:,4) armTemp(:,1) armTemp(:,2) armTemp(:,3)];                    %arm
forearmTemp = importdata([path 'Quad14.txt']);
temp.limb{3} = [forearmTemp(:,4) forearmTemp(:,1) forearmTemp(:,2) forearmTemp(:,3)];%forearm
handTemp = importdata([path 'Quad15.txt']);
temp.limb{4} = [handTemp(:,4) handTemp(:,1) handTemp(:,2) handTemp(:,3)];               %hand
%% segment the data
%add the frist index.
index=[0;index];
%check the length matched.
if index(end)~=length(temp.limb{1});       
    disp('Warnning!Data length mismatch.');
    disp(path);
end

quat = quatSeg(temp,index);
clear temp;
%segment the data whithout mark
index2 = stepDet(quat(1).limb{2}(:,1));
if length(index2) > 2
   temp = quat(1);
   temp1 = quatSeg(temp,index2);
   quat = [temp1 quat(2:end)];
end

function quat = quatSeg(quatTemp,index)
%Segment the quaternions into each motion.
N=length(index)-1;
for i = 1:N
    for j=1:4
        quat(i).limb{j}=quatTemp.limb{j}(index(i)+1:index(i+1),:);
    end
end


function index = stepDet(data)
%The function is used to detection step point.
% Input data is the detected vector.
% Putput index is the index of the step point.
THD = (max(data)-min(data))/2; %threshold
index = 0;
N = length(data);
for i= 1:N-1
    if abs(data(i+1)-data(i)) > THD
        index = [index;i];
    end
end
index = [index;N];