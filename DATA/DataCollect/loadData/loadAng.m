function [shdAng,elbAng] = loadAng(path,index,kl)
%loadAng is used to load shoulder angle and elboe angle from Result.txt files 
%   path is the directory of quaternions files.
%   index is the segment maker.
%  
%% load original data and resmap the quaternion place scale in q0
% path='G:\SNARC\DATA\患者组\白竹彩\右手\运动\1-2013-5-23 10-37-6\Result.txt';
DATA = importdata(path); %load data

% kl=2;
% count=0;
% index=[266;506;735];
%% segment the data
%add the frist index.
%index=[0;index];
a=isnan(DATA.data(1,:));
if  length(a)==6 && a(1)==1 && a(3)==1
    shd=2;
    elb=5;
elseif length(a)==5 && a(1)==0 &&a(2)==1
    shd=1;
    elb=4;
    
end
if kl==1
    shdAng=DATA.data(1:index(1),shd);
    elbAng=DATA.data(1:index(1),elb);

else 
    shdAng=DATA.data(index(kl-1)+33*(kl-1)+1:index(kl)+34*(kl-1)-(kl-1),shd);
    elbAng=DATA.data(index(kl-1)+33*(kl-1)+1:index(kl)+34*(kl-1)-(kl-1),elb);
end
    
    
