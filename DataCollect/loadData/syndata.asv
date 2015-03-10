%Load kinematic data in a array
clear;
clc;
close all;
% file name, which is same as variable name.
load('../../DATA/backup/DataA-35');
load('../../DATA/backup/DataU-11');
affected=DataA;
unaffected=DataU;
% unaffected=newDataU;
N = 3; %The Nth motion
for i = 1:length(affected)
    dataSetA.name{i} = affected(i).name;
    dataSetA.FM(i) = affected(i).FM;
    kA{i}={};
    eA{i}={};
    kU{i}={};
    eU{i}={};
    if ~isempty(affected(i).affSide) && affected(i).affSide=='ср'
        if ~(isempty(affected(i).R.flx.kin) || isempty(affected(i).R.flx.sEMG))
            for t=1:length(affected(i).R.flx.kin) 
                kA{i}=[kA{i} length(affected(i).R.flx.kin(t).limb{1})];
                %kU{i}=[kU{i} length(DataA(i).L.flx.kin(t).limb{1})];
               % dataSetA.quat(i) = affected(i).R.flx.kin(1);
            end
            for l=1:length(affected(i).R.flx.sEMG)
                eA{i}=[eA{i} length(affected(i).R.flx.sEMG{l})];
                %eU{i}=[eU{i} length(DataA(i).L.flx.sEMG{l})];
            end
        end
    else
        if ~(isempty(affected(i).L.flx.kin) || isempty(affected(i).L.flx.sEMG))
              for t=1:length(DataA(i).L.flx.kin)
                  kA{i}=[kA{i} length(affected(i).L.flx.kin(t).limb{1})];
              end
              for l=1:length(affected(i).L.flx.sEMG)
                eA{i}=[eA{i} length(affected(i).L.flx.sEMG{l})];
             end
              %dataSetA.quat(i) = affected(i).L.flx.kin(1);

         end
    end
end
for i = 1:length(affected)
    d{i}={};
    if ~isempty(affected(i).affSide) && affected(i).affSide=='ср'
        if ~(isempty(affected(i).R.flx.kin) || isempty(affected(i).R.flx.sEMG))
            for h=1:length(kA{i})
                for g=1:length(eA{i})
                    d{i}=[d{i} kA{i}{h}*20-eA{i}{g}];
                    if abs(kA{i}{h}*20-eA{i}{g})<40
                        
                         dataSetA.quat(i) = affected(i).R.flx.kin(h);
                         dataSetA.sEMG(i)=affected(i).R.flx.sEMG(g);
                         break
                    end
                end
            end
        end
           
   
    else
       
        if ~(isempty(affected(i).L.flx.kin) || isempty(affected(i).L.flx.sEMG))
             for h=1:length(kA{i})
                for g=1:length(eA{i})
                    d{i}=[d{i} kA{i}{h}*20-eA{i}{g}];
                    if abs(kA{i}{h}*20-eA{i}{g})<40
                       
                        dataSetA.quat(i) = affected(i).L.flx.kin(h);
                         dataSetA.sEMG(i)=affected(i).L.flx.sEMG(g);
                         break
                    end
                end
            end
            
        end
    end
end



for i = 1:length(unaffected)
%    if length(unaffected(i).R.flx) >= N      %Extract Nth motion
  kA{i}={};
    eA{i}={};
    kU{i}={};
    eU{i}={};
        dataSetU.name{i} = unaffected(i).name;  
       
          if ~(isempty(unaffected(i).R.flx.kin) || isempty(unaffected(i).R.flx.sEMG))
            for t=1:length(unaffected(i).R.flx.kin) 
                kA{i}=[kA{i} length(unaffected(i).R.flx.kin(t).limb{1})];
                %kU{i}=[kU{i} length(DataA(i).L.flx.kin(t).limb{1})];
               % dataSetA.quat(i) = affected(i).R.flx.kin(1);
            end
            for l=1:length(unaffected(i).R.flx.sEMG)
                eA{i}=[eA{i} length(unaffected(i).R.flx.sEMG{l})];
                %eU{i}=[eU{i} length(DataA(i).L.flx.sEMG{l})];
            end
          end
end



for i = 1:length(unaffected)
    d{i}={};
  
        if ~(isempty(unaffected(i).R.flx.kin) || isempty(unaffected(i).R.flx.sEMG))
            for h=1:length(kA{i})
                for g=1:length(eA{i})
                    d{i}=[d{i} kA{i}{h}*20-eA{i}{g}];
                    if abs(kA{i}{h}*20-eA{i}{g})<40
                        
                         dataSetU.quat(i) = unaffected(i).R.flx.kin(h);
                         dataSetU.sEMG(i)=unaffected(i).R.flx.sEMG(g);
                         break
                    end
                end
            end
        end
end
