% read data
clear all
close all
clc
%Path = 'G:\SNARC\DATA\';
Path = 'F:\SNARC-work\康复\DATA\';
oriPath=[Path '正常组'];
[fmXls,nameXls] = xlsread([Path 'profile.xlsx']);
%[fmXls,nameXls] = xlsread('F:\SNARC-work\康复\DATA\profile.xlsx');
nameList = dir(fullfile(oriPath));
EMGFLAG = 1;
for s = 1:length(nameList)-2
    DataA(s).name={};
    DataA(s).FM=NaN;
    DataA(s).affSide={};
    DataA(s).R.flx.kin=[];
    DataA(s).R.abd.kin=[];
    DataA(s).L.flx.kin=[];
    DataA(s).L.abd.kin=[];
    DataA(s).R.flx.sEMG={};
    DataA(s).R.abd.sEMG={};
    DataA(s).L.flx.sEMG={};
    DataA(s).L.abd.sEMG={};
    DataA(s).R.flx.mvc={};
    DataA(s).R.abd.mvc={};
    DataA(s).L.flx.mvc={};
    DataA(s).L.abd.mvc={};

end
for n = 1:length(nameList)-2          %traverse each person
    DataA(n).name=nameList(n+2).name;
    
    index = ismember(nameXls,DataA(n).name);
    DataA(n).FM = fmXls(index);
    
    sideList=dir(fullfile(oriPath,nameList(n+2).name));
    for i=1:length(sideList)-2  %traverse each side
        if ~(isempty(strfind(sideList(i+2).name,'偏')) && isempty(findstr(sideList(i+2).name,'瘫'))&& isempty(findstr(sideList(i+2).name,'患')))
            DataA(n).affSide=sideList(i+2).name(1);
        end
        if strcmp(sideList(i+2).name(1),'左')==1
            side='L';
        elseif strcmp(sideList(i+2).name(1),'右')==1
            side='R';
        end
        typeList=dir(fullfile(oriPath,nameList(n+2).name,sideList(i+2).name)); 
        for j=1:length(typeList)-2                      
            if strcmp(typeList(j+2).name,'运动')==1
                collTime=dir(fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name));
                for k=1:length(collTime)-2          %traverse each data as 林翰飞2\右\运动\18-2014-12-10 16-10-18 
                    pathNameR=fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name,collTime(k+2).name,'Result.txt');
                    pathNameQ=fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name,collTime(k+2).name,'\');
                    [index,motion] = readRes(pathNameR);
                    if ~isempty(index)          
                        if ((side=='L')&&(motion=='1')) 
                           DataA(n).L.flx.kin= [DataA(n).L.flx.kin loadQuat(pathNameQ,index)];
                        elseif ((side=='L')&&(motion=='3')) 
                           DataA(n).L.abd.kin= [DataA(n).L.abd.kin loadQuat(pathNameQ,index)];
                        elseif ((side=='R')&&(motion=='1')) 
                           DataA(n).R.flx.kin= [DataA(n).R.flx.kin loadQuat(pathNameQ,index)];
                        elseif ((side=='R')&&(motion=='3')) 
                           DataA(n).R.abd.kin= [DataA(n).R.abd.kin loadQuat(pathNameQ,index)];
                            
                        end 
                    end
                end
            end
            
            if strcmp(typeList(j+2).name,'肌电')==1 && EMGFLAG
                t=zeros(1,8)+1;
                fileList=dir(fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name));
                for l=1:length(fileList)-2
                    pathE=fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name,fileList(l+2).name);
                   
                    if ~isempty(strfind(fileList(l+2).name,'motionL1')) 
                           DataA(n).L.flx.sEMG=[DataA(n).L.flx.sEMG loadEmg(pathE)];
                        elseif ~isempty(strfind(fileList(l+2).name,'motionL2'))   
                           DataA(n).L.abd.sEMG=[DataA(n).L.abd.sEMG loadEmg(pathE)];
                        elseif ~isempty(strfind(fileList(l+2).name,'motionR1')) 
                           DataA(n).R.flx.sEMG=[DataA(n).R.flx.sEMG loadEmg(pathE)];
                        elseif ~isempty(strfind(fileList(l+2).name,'motionR2')) 
                           DataA(n).R.abd.sEMG= [DataA(n).R.abd.sEMG loadEmg(pathE)];
                        elseif ~isempty(strfind(fileList(l+2).name,'mvcR1'))
                           DataA(n).R.flx.mvc= [DataA(n).R.flx.mvc loadEmg(pathE)];
                        elseif ~isempty(strfind(fileList(l+2).name,'mvcR2'))
                           DataA(n).R.abd.mvc=[DataA(n).R.abd.mvc loadEmg(pathE)];
                        elseif (strfind(fileList(l+2).name,'mvcL1'))
                           DataA(n).L.flx.mvc= [DataA(n).L.flx.mvc loadEmg(pathE)];
                        elseif (strfind(fileList(l+2).name,'mvcL2'))
                           DataA(n).L.abd.mvc= [DataA(n).L.abd.mvc loadEmg(pathE)]; 
                    end 
                end
            end
                
        end 
    end
   
end
