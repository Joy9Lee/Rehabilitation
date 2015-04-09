function [loc0, loc]=subsection(dataPath,dataName,varargin)
% clc
% close all
% clear all
%Cut the each row or column of the input array into two parts, the varying
%part and the smooth part, isometric and isotonic.
%Input data is a MxN array
error(nargchk(2,3,nargin));
if nargin ==3 && varargin{1}==1
    Display = 1;
else
    Display = 0;
end
fs=50;
%load('../DATA/dataSetA');
%inData=dataSetA;
%load('../DATA/SynDataA');
load(dataPath);
inData=dataName;
win=6;
%% IntoPart function

for i=1:length(inData.quat)
    %if ~isempty(inData.quat{i})

    N = size(inData.quat(i).limb{2});
    %mark the start index
    loc0(i) = markStart(inData.quat(i).limb{2}(:,1));
   %mark the index between the isometric and isotonic.
    x(i,1) = LineSec(inData.quat(i).limb{2}(:,1));
    loc(i) = max(x(i,:));

    %end
    
end
%Display
if Display
    figure
    for i=1:length(inData.quat)
        subplot(7,5,i)
        plot(inData.quat(i).limb{2}(:,1));
        hold on;
        plot([loc(i) loc(i)],[0.8 1],'--m');
        plot([loc0(i) loc0(i)],[0.8 1],'--k');
        grid on;
    end
end

function index = markStart(scale)
%mark the index of motion start
for i = 1:length(scale)
    index = 200;
    if scale(i)<0.995
       index = i;
        break;
    end
end