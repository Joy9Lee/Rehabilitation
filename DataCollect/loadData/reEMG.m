%Load kinematic and EMG data in a array
clear;
clc;
close all;
% file name, which is same as variable name.
load('../../DATA/backup/DataA-35');
load('../../DATA/backup/DataU-11');
load('../../DATA/dataSetA');
load('../../DATA/dataSetU');
affected=DataA;
unaffected=DataU;
% unaffected=newDataU;
N = 3; %The Nth motion
for i = 1:length(affected)
    dataSetA.name{i} = affected(i).name;
    dataSetA.FM(i) = affected(i).FM;
    if ~isempty(affected(i).affSide) && affected(i).affSide=='ср'
        if ~(isempty(affected(i).R.flx.kin) || isempty(affected(i).R.flx.sEMG))
%            if length(affected(i).R.flx.kin) >= N    %Extract Nth motion
                dataSetA.quat(i) = affected(i).R.flx.kin(1);
                dataSetA.sEMG(i)=affected(i).R.flx.sEMG(1);
            %end 
        end
    else
          if ~(isempty(affected(i).L.flx.kin) || isempty(affected(i).L.flx.sEMG))
%            if length(affected(i).L.flx.kin)>=N
                dataSetA.quat(i) = affected(i).L.flx.kin(1);
                dataSetA.sEMG{i}=affected(i).L.flx.sEMG{1};
%             end
         end
    end
end
%dataSetA.name = dataSetA.name';
dataSetA.sEMG = dataSetA.sEMG';

for i = 1:length(unaffected)
%    if length(unaffected(i).R.flx) >= N      %Extract Nth motion
        dataSetU.name{i} = unaffected(i).name;  
        if ~(isempty(unaffected(i).R.flx.kin) || isempty(unaffected(i).R.flx.sEMG))
            dataSetU.quat(i) = unaffected(i).R.flx.kin(1);
            dataSetU.sEMG{i}=unaffected(i).R.flx.sEMG{1};
        end
%    end

end
%dataSetU.name = dataSetU.name';
dataSetU.sEMG = dataSetU.sEMG';