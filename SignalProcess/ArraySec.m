clc
close all
clear all
%Cut the each row or column of the input array into two parts, the varying part and the smooth part
%Input data is a MxN array

fs=50;
load('../DATA/quatA');
data=dataSetA;
inData=data;
win=6;
%% IntoPart function
for i=1:length(inData)
     if isfield(inData(i).R,'flx')
        if isfield(inData(i).R.flx,'kin')
            s=size(inData(i).R.flx.kin(1).limb{4});
            for r=1:s(2)
                x(i,r)=LineSec(inData(i).R.flx.kin(1).limb{4}(:,r));
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