%Load kinematic data in a array
clear;
clc;
close all;
% file name, which is same as variable name.
% load('../../backup/DataA');
% load('../../backup/DataU');
load('../../DataA16_M3')
%load('../../DataA_35');
load('../../DataU19_M3');
affected=DataA;
unaffected=DataU;
%% restruct patients' data
for i = 1:length(affected)
    kineA.name{i} = affected(i).name';  %affected
    kineA.group(i) = affected(i).group; 
    kineA.FM(i) = affected(i).FM; 
    if ~isempty(affected(i).affSide) && affected(i).affSide=='ср'
        if ~isempty(affected(i).R.flx.shdAng)   
            kineA.shdAng{i} = affected(i).R.flx.shdAng;         %affected side
            kineA.elbAng{i} = affected(i).R.flx.elbAng;
             kineA.divE{i} = affected(i).R.flx.divE;
              kineA.divS{i} = affected(i).R.flx.divS;
            kineA.EMG{i} = affected(i).R.flx.sEMG;
             kineA.quat(i) = affected(i).R.flx.quat;
        end
        if ~isempty(affected(i).L.flx.sEMG)
            kineA.shdAngU{i} = affected(i).L.flx.shdAng;         %patients' unaffected side
            kineA.elbAngU{i} = affected(i).L.flx.elbAng;
             kineA.divEU{i} = affected(i).L.flx.divE;
             kineA.divSU{i} = affected(i).L.flx.divS;
              kineA.quatL(i) = affected(i).L.flx.quat;
            kineA.EMGU{i} = affected(i).L.flx.sEMG;  
        end
    else
        if ~isempty(affected(i).L.flx.sEMG)  
            kineA.shdAng{i} = affected(i).L.flx.shdAng;         %affected side
            kineA.elbAng{i} = affected(i).L.flx.elbAng;
            kineA.divE{i} = affected(i).L.flx.divE;
             kineA.divS{i} = affected(i).L.flx.divS;
              kineA.quat(i) = affected(i).L.flx.quat;
            kineA.EMG{i} = affected(i).L.flx.sEMG;  
        end
        if ~isempty(affected(i).R.flx.sEMG)
            kineA.shdAngU{i} = affected(i).R.flx.shdAng;         %affected side
            kineA.elbAngU{i} = affected(i).R.flx.elbAng;
            kineA.divEU{i} = affected(i).R.flx.divE;
              kineA.divSU{i} = affected(i).R.flx.divS;
                kineA.quatL(i) = affected(i).R.flx.quat;
            kineA.EMGU{i} = affected(i).R.flx.sEMG;
        end
    end
end
kineA.name = kineA.name';
kineA.group=kineA.group';
kineA.shdAng= kineA.shdAng';
kineA.elbAng= kineA.elbAng';
kineA.quat= kineA.quat';
kineA.quatL= kineA.quatL';
kineA.EMG= kineA.EMG';
kineA.shdAngU= kineA.shdAngU';
kineA.elbAngU=kineA.elbAngU';
kineA.EMGU= kineA.EMGU';
kineA.FM=kineA.FM';
kineA.divEU=kineA.divEU';
kineA.divSU=kineA.divSU';
kineA.divE=kineA.divE';
kineA.divS=kineA.divS';
%% restuct controls' data

for i = 1:length(unaffected)
    kineU.name{i} = unaffected(i).name;
    if ~isempty(unaffected(i).R.flx.sEMG)
        kineU.shdAngR{i} = unaffected(i).R.flx.shdAng;         %affected side
        kineU.elbAngR{i} = unaffected(i).R.flx.elbAng;
         kineU.quat(i) = unaffected(i).R.flx.quat;
        kineU.EMGR{i} = unaffected(i).R.flx.sEMG;
    end
    if ~isempty(unaffected(i).L.flx.sEMG)
        kineU.shdAngL{i} = unaffected(i).L.flx.shdAng;         %affected side
        kineU.elbAngL{i} = unaffected(i).L.flx.elbAng;
        kineU.EMGL{i} = unaffected(i).L.flx.sEMG;
         kineU.quatL(i)= unaffected(i).L.flx.quat;
    end  
end
kineU.name = kineU.name';
kineU.shdAngR=kineU.shdAngR';
kineU.elbAngR=kineU.elbAngR';
kineU.EMGR=kineU.EMGR';
kineU.shdAngL=kineU.shdAngL';
kineU.elbAngL=kineU.elbAngL';
kineU.EMGL=kineU.EMGL';
 kineU.quatL= kineU.quatL';
  kineU.quat= kineU.quat';