% jointAng.m
% calculate shouder angle and elbow angle in the motion of reaching objects.
% the calculation uses the function getJointAng from path
% 'G:\SNARC\肌电资料\康复资料\文档\帅哥\交接\康复评估\Matlab\获取MFI'
% the angle is saved in ang.mat,which contains the fields of ang.shdA, ang.shdC, ang.elbA and ang.elbC
function ang=jointAng(indata,flag,varargin)
% clc;    clear;    close all;
% addpath('G:\SNARC\肌电资料\康复资料\文档\帅哥\交接\康复评估\Matlab\获取MFI');
% addpath('G:\SNARC\肌电资料\康复资料\文档\帅哥\交接\康复评估\Matlab\获取MFI\Quaternion');
% load('../../DATA/SynDataA');
% load('../../DATA/SynDataU');
% Kind=1;              % Kind = 1 --> patient; Kind = 0 --> normal person
% switch Kind
%     case 1
%         inData=SynDataA;
%     case 0
%         inData=SynDataU;
%     otherwise
%         error('The wrong kind!');
% end
error(nargchk(2,3,nargin));
if nargin ==3 && varargin{1}==1
    Display = 1;
else
    Display = 0;
end
SynDataA=indata;
for i=1:length(SynDataA.name)
    for j=1:4
        SynDataA.quat(i).limb{j}=[SynDataA.quat(i).limb{j}(:,2) SynDataA.quat(i).limb{j}(:,3) SynDataA.quat(i).limb{j}(:,4) SynDataA.quat(i).limb{j}(:,1)];
    end
end

for i=1:length(SynDataA.name)
    ang{i} = abs(getJointAng(SynDataA.quat(i).limb{2},SynDataA.quat(i).limb{3},SynDataA.quat(i).limb{4},flag));
    if Display
        subplot(4,6,i)
        plot(ang{i})
        if isfield(SynDataA,'FM')
            title(['FM=' num2str(SynDataA.FM(i)) SynDataA.name{i}]);
        end
%        hold on
%         plot([SynDataA.loc(i) SynDataA.loc(i)],[0 100],'--m');
%         plot([SynDataA.loc0(i) SynDataA.loc0(i)],[0 100],'--k');
         ylim([0 100])
    end
end
if Display
    if flag==1
        suptitle('shdAngle')
    elseif flag==7
        suptitle('elbowAngle')
    end
end

% ang.shdA=ang.shdA';
% ang.shdC=ang.shdC';
% ang.elbA=ang.elbA';
% ang.elbC=ang.elbC';