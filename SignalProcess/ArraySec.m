clc
close all
clear all
fs=50;
filePath='G:\SNARC\Rehabilitation\DATA\newDataU.mat';
load(filePath);
data=newDataU;
inData=data;
win=6;
%% IntoPart function
for i=1:length(inData)
     if isfield(inData(i).R,'flx')
        if isfield(inData(i).R.flx,'kin')
            s=size(inData(i).R.flx.kin(1).limb{4});
            for r=1:s(2)
                x(i,r)=LineSec(inData(i).R.flx.kin(1).limb{4}(:,r)');
            end
            
            if 1
                figure
                plot(inData(i).R.flx.kin(1).limb{4})
                hold on
                grid on;
            end
         end
     end
    loc(i)=max(x(i,:));
end