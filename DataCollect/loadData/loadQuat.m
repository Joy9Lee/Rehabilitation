function quat = loadQuat(path,index)
%loadQuat is used to collect the segmented quaternion from quad files 
%Quad3.txt, Quad13.txt, Quad14.txt, Quad15.txt. And returen the organized data. 
%   path is the directory of quaternions files.
%   index is the segment maker.
%   quat is organized quaternions data. 
%   qiat{i}.limb(j) indicate the section of the motion, and j indicate the
%   limb. 1=waist 2=arm 3=forearm 4=hand.
%% load original data
%path='F:\SNARC-work\康复\DATA\正常组\干汝起\右手\运动\1-2013-11-21 11-6-48\';
waist = importdata([path 'Quad3.txt']);
arm = importdata([path 'Quad13.txt']);
forearm = importdata([path 'Quad14.txt']);
hand = importdata([path 'Quad15.txt']);
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
