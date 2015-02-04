function quat = loadQuat(path,index)
%loadQuat is used to collect the segmented quaternion from quad files 
%Quad3.txt, Quad13.txt, Quad14.txt, Quad15.txt. And returen the organized data. 
%   path is the directory of quaternions files.
%   index is the segment maker.
%   quat is organized quaternions data. q0 place the scale. 
%   qiat{i}.limb(j) indicate the section of the motion, and j indicate the
%   limb. 1=waist 2=arm 3=forearm 4=hand.
%% load original data and resmap the quaternion place scale in q0
%path='F:\SNARC-work\康复\DATA\正常组\干汝起\右手\运动\1-2013-11-21 11-6-48\';
%index=[100;300];
waistTemp = importdata([path 'Quad3.txt']);
waist = [waistTemp(:,4) waistTemp(:,1) waistTemp(:,2) waistTemp(:,3)];
armTemp = importdata([path 'Quad13.txt']);
arm = [armTemp(:,4) armTemp(:,1) armTemp(:,2) armTemp(:,3)];
forearmTemp = importdata([path 'Quad14.txt']);
forearm = [forearmTemp(:,4) forearmTemp(:,1) forearmTemp(:,2) forearmTemp(:,3)];
handTemp = importdata([path 'Quad15.txt']);
hand = [handTemp(:,4) handTemp(:,1) handTemp(:,2) handTemp(:,3)];
%% segment the data
N=length(index);
%check the length matched.
if index(N)-1~=length(waist);       
    disp('Warnning!Data length mismatch.');
    disp(path);
end
%add the frist index.
index=[1;index];
for i = 1:N
    quat(i).limb{1}=waist(index(i):index(i+1)-1,:);
    quat(i).limb{2}=arm(index(i):index(i+1)-1,:);
    quat(i).limb{3}=forearm(index(i):index(i+1)-1,:);
    quat(i).limb{4}=hand(index(i):index(i+1)-1,:);
end
