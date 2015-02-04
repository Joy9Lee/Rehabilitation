%Load kinematic data in a array
clear;
clc;
close all;
load('../../DATA/unaffected');
load('../../DATA/affected');
N = 3; %The Nth motion
for i = 1:length(affected)
    dataSetA.name{i} = affected(i).name;
    if affected(i).affSide=='ср'
        if ~isempty(affected(i).R)
            if length(affected(i).R.flx) >= N
                dataSetA.quat(i) = affected(i).R.flx{N};
            end
        end
    else
         if ~isempty(affected(i).L)
            if length(affected(i).L.flx)>=N
                dataSetA.quat(i) = affected(i).L.flx{N};
            end
         end
    end
end
dataSetA.name = dataSetA.name';

for i = 1:length(unaffected)
    if length(unaffected(i).R.flx) >= N
       dataSetU.name{i} = unaffected(i).name;
       dataSetU.quat(i) = unaffected(i).R.flx{N};
    end

end
dataSetU.name = dataSetU.name';