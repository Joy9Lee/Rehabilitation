%Load kinematic data in a array
clear;
clc;
close all;
% file name, which is same as variable name.
load('../../DATA/backup/DataA-35');
load('../../DATA/backup/DataU-11');
affected=DataA;
unaffected=DataU;
N = 3; %The Nth motion
%% restruct patients' data
for i = 1:length(affected)
<<<<<<< HEAD:DataCollect/loadData/restruct.m
    kineA.name{i} = affected(i).name;
    kineA.FM(i) = affected(i).FM;
=======
    kineA.name{i} = affected(i).name';  %affected
    kineA.FM(i) = affected(i).FM;
    kineUA.name{i} = affected(i).name'; %unaffected
    kineUA.FM(i) = affected(i).FM;
>>>>>>> 71d8a58c36b86ee2c88f4c01568b9b60eeb6eca4:DataCollect/loadData/restruct.m
    if ~isempty(affected(i).affSide) && affected(i).affSide=='ср'
        if ~isempty(affected(i).R.flx.kin)
%            if length(affected(i).R.flx.kin) >= N    %Extract Nth motion
                kineA.quat(i) = affected(i).R.flx.kin(1);
<<<<<<< HEAD:DataCollect/loadData/restruct.m
            %end 
=======
            %end
        end
    
        if ~isempty(affected(i).L.flx.kin)
                kineUA.quat(i) = affected(i).L.flx.kin(1);
>>>>>>> 71d8a58c36b86ee2c88f4c01568b9b60eeb6eca4:DataCollect/loadData/restruct.m
        end
    else
          if ~isempty(affected(i).L.flx.kin)
%            if length(affected(i).L.flx.kin)>=N
                kineA.quat(i) = affected(i).L.flx.kin(1);
%             end
          end
          if ~isempty(affected(i).R.flx.kin)
                kineUA.quat(i) = affected(i).R.flx.kin(1);
          end
    end
end
<<<<<<< HEAD:DataCollect/loadData/restruct.m
kineA.name = kineA.name';

=======
%% restuct controls' data
>>>>>>> 71d8a58c36b86ee2c88f4c01568b9b60eeb6eca4:DataCollect/loadData/restruct.m
for i = 1:length(unaffected)
%    if length(unaffected(i).R.flx) >= N      %Extract Nth motion
        kineU.name{i} = unaffected(i).name;  
        if ~isempty(unaffected(i).R.flx.kin)
            kineU.quat(i) = unaffected(i).R.flx.kin(1);
        end
%    end

end
kineU.name = kineU.name';