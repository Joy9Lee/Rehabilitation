% read data
clear all
close all
clc
oriPath='G:\SNARC\����\������';
nameList = dir(fullfile(oriPath));
for n = 1:length(nameList)-2
    DataA(n).name=nameList(n+2).name;
    sideList=dir(fullfile(oriPath,nameList(n+2).name));
    for i=1:length(sideList)-2
        if ~(isempty(findstr(sideList(i+2).name,'ƫ')) && isempty(findstr(sideList(i+2).name,'̱')))
            DataA(n).affSide=sideList(i+2).name(1);
        end
        if strcmp(sideList(i+2).name(1),'��')==1
            side='L';
        elseif strcmp(sideList(i+2).name(1),'��')==1
            side='R';
        end
        typeList=dir(fullfile(oriPath,nameList(n+2).name,sideList(i+2).name));
        for j=1:length(typeList)-2
            if strcmp(typeList(j+2).name,'�˶�')==1
                collTime=dir(fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name));
                for k=1:length(collTime)-2
                    pathNameR=fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name,collTime(k+2).name,'Result.txt');
                    pathNameQ=fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name,collTime(k+2).name,'\');
                    [index,motion] = readRes(pathNameR);
                    if ~isempty(index)
                        if ((side=='L')&&(motion=='1')) 
                           DataA(n).L.flx= loadQuat(pathNameQ,index);
                        elseif ((side=='L')&&(motion=='3')) 
                           DataA(n).L.abd= loadQuat(pathNameQ,index);
                        elseif ((side=='R')&&(motion=='1')) 
                           DataA(n).R.flx= loadQuat(pathNameQ,index);
                        elseif ((side=='R')&&(motion=='3')) 
                           DataA(n).R.abd= loadQuat(pathNameQ,index);
                            
                        end 
                    end
                end
            end
            
        %data(i)=load(fullfile(PATH_NAME,nameList(n+2).name,handList(i+2).name));
        %rawdata{i}=data(i).datablock1.data;
        end
        
    end
end