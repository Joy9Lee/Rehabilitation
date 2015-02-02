function quat = loadQuat(path,index)
%loadQuat is used to collect the segmented quaternion from quad files 
%Quad3.txt, Quad13.txt, Quad14.txt, Quad15.txt. And returen the organized data. 
%   path is the directory of quaternions files.
%   index is the segment maker.
%   quat is organized quaternions data. 
%   qiat{i}.limb(j) indicate the section of the motion, and j indicate the
%   limb. 1=waist 2=arm 3=forearm 4=hand.
%% load original data
%path='G:\SNARC\数据\患者组\姜明\右手偏\运动\1-2013-11-21 10-10-6\';
waist = load([path 'Quad3.txt']);
arm = load([path 'Quad13.txt']);
forearm = load([path 'Quad14.txt']);
hand = load([path 'Quad15.txt']);
%% segment the data
N=length(index);
%check the length matched.
if index(N)-1~=length(waist);       
    disp('Warnning!Data length mismatch.');
end
%add the frist index.
index=[1;index];
for i = 1:N
    quat{i}.limb{1}=waist(index(i):index(i+1)-1,:);
    quat{i}.limb{2}=arm(index(i):index(i+1)-1,:);
    quat{i}.limb{3}=forearm(index(i):index(i+1)-1,:);
    quat{i}.limb{4}=hand(index(i):index(i+1)-1,:);
end
