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
    
   
    kA{i}={};               %length of affected kinemic data
    eA{i}={};               %length of affected EMG data
    kU{i}={};               %length of unaffected kinemic data
    eU{i}={};               %length of unaffected EMG data
    if ~isempty(affected(i).affSide) && affected(i).affSide=='ср'
        if ~(isempty(affected(i).R.flx.kin) || isempty(affected(i).R.flx.sEMG))
            for t=1:length(affected(i).R.flx.kin) 
                kA{i}=[kA{i} length(affected(i).R.flx.kin(t).limb{1})];  
            end
            for l=1:length(affected(i).R.flx.sEMG)
                eA{i}=[eA{i} length(affected(i).R.flx.sEMG{l})];
               
            end
            if ~(isempty(affected(i).L.flx.kin) || isempty(affected(i).L.flx.sEMG))
                for tU=1:length(affected(i).L.flx.kin) 
                    kU{i}=[kU{i} length(affected(i).L.flx.kin(tU).limb{1})];  
                end
                for l=1:length(affected(i).L.flx.sEMG)
                    eU{i}=[eU{i} length(affected(i).L.flx.sEMG{l})];
                end
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
              if ~(isempty(affected(i).R.flx.kin) || isempty(affected(i).R.flx.sEMG))
                for tU=1:length(affected(i).R.flx.kin) 
                    kU{i}=[kU{i} length(affected(i).R.flx.kin(tU).limb{1})];  
                end
                for lU=1:length(affected(i).R.flx.sEMG)
                    eU{i}=[eU{i} length(affected(i).R.flx.sEMG{lU})];
               
                end
              

              end
        end
    end
end
for i = 1:length(affected)
    d{i}={};
    if ~isempty(affected(i).affSide) && affected(i).affSide=='ср'
        %if ~(isempty(affected(i).R.flx.kin) || isempty(affected(i).R.flx.sEMG)|| isempty(affected(i).R.flx.mvc))
        if ~(isempty(affected(i).R.flx.kin) || isempty(affected(i).R.flx.sEMG))
            for h=1:length(kA{i})
                for g=1:length(eA{i})
                    d{i}=[d{i} kA{i}{h}*20-eA{i}{g}];
                    if abs(kA{i}{h}*20-eA{i}{g})<40
                        synDataA.name{i} = affected(i).name;
                        synDataA.FM(i) = affected(i).FM;
                        synDataA.quatA(i) = affected(i).R.flx.kin(h);
                        synDataA.sEMGA(i)=affected(i).R.flx.sEMG(g);
                        synDataA.mvcA{i}=affected(i).R.flx.mvc{1};
                       
                        break
                    end
                end
            end
            %if ~(isempty(affected(i).L.flx.kin) || isempty(affected(i).L.flx.sEMG)|| isempty(affected(i).L.flx.mvc))
             if ~(isempty(affected(i).L.flx.kin) || isempty(affected(i).L.flx.sEMG))
                for h=1:length(kU{i})
                    for g=1:length(eU{i})
                        if abs(kU{i}{h}*20-eU{i}{g})<40                     
                            synDataA.quatU(i) = affected(i).L.flx.kin(h);
                            synDataA.sEMGU(i)=affected(i).L.flx.sEMG(g);
                            synDataA.mvcU{i}=affected(i).L.flx.mvc{1};
                            break
                        end
                    end
                end
            end
                
        end
           
   
    else
                                                                                       %left side is the affected side
        if ~(isempty(affected(i).L.flx.kin) || isempty(affected(i).L.flx.sEMG))
             for h=1:length(kA{i})
                for g=1:length(eA{i})
                    d{i}=[d{i} kA{i}{h}*20-eA{i}{g}];
                    if abs(kA{i}{h}*20-eA{i}{g})<40
                         synDataA.name{i} = affected(i).name;
                         synDataA.FM(i) = affected(i).FM;
                         synDataA.quatA(i) = affected(i).L.flx.kin(h);
                         synDataA.sEMGA(i)=affected(i).L.flx.sEMG(g);
                         synDataA.mvcA{i}=affected(i).L.flx.mvc{1};
                         
                         break
                    end
                end
            end
            if ~(isempty(affected(i).R.flx.kin) || isempty(affected(i).R.flx.sEMG)|| isempty(affected(i).R.flx.mvc))
                for h=1:length(kU{i})
                    for g=1:length(eU{i})
                        
                        if abs(kU{i}{h}*20-eU{i}{g})<40
                        
                            synDataA.quatU(i) = affected(i).R.flx.kin(h);
                            synDataA.sEMGU(i)=affected(i).R.flx.sEMG(g);
                            synDataA.mvcU{i}=affected(i).R.flx.mvc{1};
                            break
                        end
                    end
                end
            end
        end
    end
end

synDataA.name = synDataA.name';
synDataA.FM=synDataA.FM';
synDataA.mvcA = synDataA.mvcA';
synDataA.sEMGA = synDataA.sEMGA';
synDataA.mvcU = synDataA.mvcU';
synDataA.sEMGU = synDataA.sEMGU';
synDataA.quatA=synDataA.quatA';
synDataA.quatU=synDataA.quatU';
kA=kA';

for i = 1:length(unaffected)
%    if length(unaffected(i).R.flx) >= N      %Extract Nth motion
    kA{i}={};
    eA{i}={};
    kU{i}={};
    eU{i}={};
    synDataU.name{i} = unaffected(i).name;  
    if ~(isempty(unaffected(i).R.flx.kin) || isempty(unaffected(i).R.flx.sEMG))
        for t=1:length(unaffected(i).R.flx.kin) 
            kA{i}=[kA{i} length(unaffected(i).R.flx.kin(t).limb{1})];
        end
        for l=1:length(unaffected(i).R.flx.sEMG)
            eA{i}=[eA{i} length(unaffected(i).R.flx.sEMG{l})];
        end
   end
end
for i = 1:length(unaffected)
    d{i}={};
    if ~(isempty(unaffected(i).R.flx.kin) || isempty(unaffected(i).R.flx.sEMG)|| isempty(unaffected(i).R.flx.mvc))
        for h=1:length(kA{i})
            for g=1:length(eA{i})
                d{i}=[d{i} kA{i}{h}*20-eA{i}{g}];
                if abs(kA{i}{h}*20-eA{i}{g})<40
                    synDataU.quat(i) = unaffected(i).R.flx.kin(h);
                    synDataU.sEMG(i)=unaffected(i).R.flx.sEMG(g);
                    synDataU.mvc{i}=unaffected(i).R.flx.mvc{1};
                    break
                end
            end
        end
    end
end
kA=kA';

% for i = 1:length(unaffected)
% %    if length(unaffected(i).R.flx) >= N      %Extract Nth motion
%     kA{i}={};
%     eA{i}={};
%     kU{i}={};
%     eU{i}={};
%     synDataU.name{i} = unaffected(i).name;  
%     if ~(isempty(unaffected(i).L.flx.kin) || isempty(unaffected(i).L.flx.sEMG))
%         for t=1:length(unaffected(i).L.flx.kin) 
%             kA{i}=[kA{i} length(unaffected(i).L.flx.kin(t).limb{1})];
%         end
%         for l=1:length(unaffected(i).L.flx.sEMG)
%             eA{i}=[eA{i} length(unaffected(i).L.flx.sEMG{l})];
%         end
%    end
% end
% for i = 1:length(unaffected)
%     d{i}={};
%     if ~(isempty(unaffected(i).L.flx.kin) || isempty(unaffected(i).L.flx.sEMG)|| isempty(unaffected(i).L.flx.mvc))
%         for h=1:length(kA{i})
%             for g=1:length(eA{i})
%                 d{i}=[d{i} kA{i}{h}*20-eA{i}{g}];
%                 if abs(kA{i}{h}*20-eA{i}{g})<40
%                     synDataU.quat(i) = unaffected(i).L.flx.kin(h);
%                     synDataU.sEMG(i)=unaffected(i).L.flx.sEMG(g);
%                     synDataU.mvc{i}=unaffected(i).L.flx.mvc{1};
%                     break
%                 end
%             end
%         end
%     end
% end