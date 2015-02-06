%Load kinematic data in a array
% clear;
% clc;
% close all;
%file name, which is same as variable name.
% load('../../DATA/newDataA');
% load('../../DATA/newDataU');
affected=DataA;
% unaffected=newDataU;
N = 3; %The Nth motion
for i = 1:length(affected)
    dataSetA.name{i} = affected(i).name;
    dataSetA.FM(i) = affected(i).FM;
    if ~isempty(affected(i).affSide) && affected(i).affSide=='��'
        if ~isempty(affected(i).R.flx.kin)
%            if length(affected(i).R.flx.kin) >= N    %Extract Nth motion
                dataSetA.quat(i) = affected(i).R.flx.kin(1);
            %end 
        end
    else
          if ~isempty(affected(i).L.flx.kin)
%            if length(affected(i).L.flx.kin)>=N
                dataSetA.quat(i) = affected(i).L.flx.kin(1);
%             end
         end
    end
end
dataSetA.name = dataSetA.name';

% for i = 1:length(unaffected)
% %    if length(unaffected(i).R.flx) >= N      %Extract Nth motion
%         dataSetU.name{i} = unaffected(i).name;  
%         dataSetU.quat(i) = unaffected(i).R.flx.kin(1);
%            
% %    end
% 
% end
% dataSetU.name = dataSetU.name';