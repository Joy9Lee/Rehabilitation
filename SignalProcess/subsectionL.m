% <<<<<<< HEAD:SignalProcess/subsection.m
% =======
% %function [loc0, loc1]=subsection(dataPath,dataName,varargin)
% >>>>>>> 71d8a58c36b86ee2c88f4c01568b9b60eeb6eca4:SignalProcess/subsection.m
function [loc0, loc1]=subsectionL(dataName,varargin)
% clc
% close all
% clear all
%Cut the each row or column of the input array into two parts, the varying
%part and the smooth part, isometric and isotonic.
%Input data is a MxN array
error(nargchk(1,2,nargin));
if nargin ==2 && varargin{1}==1
    Display = 1;
else
    Display = 0;
end
fs=50;
%load('../DATA/dataSetA');
%inData=dataSetA;
%load('../DATA/SynDataA');
loc0=0;
loc1=0;
inData=dataName;
win=6;
%% IntoPart function

for i=1:length(inData.quatL)
     if ~isempty(inData.quatL(i).limb)

%<<<<<<< HEAD:SignalProcess/subsection.m
    N = size(inData.quatL(i).limb{2});
    %mark the start index
    loc0(i) = markStart(inData.quatL(i).limb{2}(:,1));
   %mark the index between the isometric and isotonic.
    x(i,1) = LineSec(inData.quatL(i).limb{2}(:,1));
    loc1(i) = max(x(i,:));
%=======
        N = size(inData.quatL(i).limb{2});
        %mark the start index
        loc0(i) = markStart(inData.quatL(i).limb{2}(:,1));
       %mark the index between the isometric and isotonic.
        x(i,1) = LineSec(inData.quatL(i).limb{2}(:,1));
        loc1(i) = max(x(i,:));
%>>>>>>> 71d8a58c36b86ee2c88f4c01568b9b60eeb6eca4:SignalProcess/subsection.m

     end
    
end
%Display
if Display
    figure
    for i=1:length(inData.quatL)
         if ~isempty(inData.quatL(i).limb)

        subplot(8,5,i)
        plot(inData.quatL(i).limb{2}(:,1));
        hold on;
        plot([loc1(i) loc1(i)],[0.8 1],'--m');
        plot([loc0(i) loc0(i)],[0.8 1],'--k');
        grid on;
         end
    end
end
inData.loc0 = loc0;
inData.loc1 = loc1;
x=1;
function index = markStart(scale)
%mark the index of motion start
for i = 1:length(scale)
    index = 200;
    if scale(i)<0.995
       index = i;
        break;
    end
end