%Load kinematic data in a array
clear;
clc;
close all;
%file name, which is same as variable name.
load('../../DATA/newDataA');
load('../../DATA/newDataU');
affected=newDataA;
unaffected=newDataU;
N = 3; %The Nth motion
for i = 1:length(affected)
    dataSetA.name{i} = affected(i).name;
    if affected(i).affSide=='ср'
%         if ~isempty(affected(i).R)
        if isfield(affected(i).R,'flx')
%            if length(affected(i).R.flx.kin) >= N    %Extract Nth motion
             if isfield(affected(i).R.flx,'kin')
                dataSetA.quat(i) = affected(i).R.flx.kin(1);
            end 
%              end
        end
    else
%          if ~isempty(affected(i).L)
        if isfield(affected(i).L,'flx')
%            if length(affected(i).L.flx.kin)>=N
                dataSetA.quat(i) = affected(i).L.flx.kin(1);
%             end
         end
    end
end
dataSetA.name = dataSetA.name';

for i = 1:length(unaffected)
%    if length(unaffected(i).R.flx) >= N      %Extract Nth motion
        dataSetU.name{i} = unaffected(i).name;  
        dataSetU.quat(i) = unaffected(i).R.flx.kin(1);
           
%    end

end
dataSetU.name = dataSetU.name';