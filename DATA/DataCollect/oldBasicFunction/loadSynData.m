% read data
close all; clear; clc;
Path = 'G:\SNARC\DATA\';

%Path = 'F:\SNARC-work\康复\DATA\';
%oriPath=[Path '正常组'];
oriPath=[Path '患者组'];
%oriPath=[Path '新患者组'];
%oriPath=[Path '新正常组'];
[fmXls,nameXls] = xlsread([Path 'profile.xlsx']);
%[fmXls,nameXls] = xlsread('F:\SNARC-work\康复\DATA\profile.xlsx');
nameList = dir(fullfile(oriPath));
EMGFLAG = 1;

for s = 1:length(nameList)-2
    DataA(s).name={};
    DataA(s).group=NaN;
    DataA(s).FM=NaN;
    DataA(s).affSide={};
    %  DataA(s).R.flx.kin=[];
    % DataA(s).R.abd.kin=[];
    %  DataA(s).L.flx.kin=[];
    %DataA(s).L.abd.kin=[];
    DataA(s).R.flx.sEMG={};
    % DataA(s).R.abd.sEMG={};
    DataA(s).L.flx.sEMG={};
    DataA(s).R.flx.shdAng={};
    DataA(s).L.flx.shdAng={};
    % DataA(s).L.abd.sEMG={};
    % DataA(s).R.flx.mvc={};
    % DataA(s).R.abd.mvc={};
    % DataA(s).L.flx.mvc={};
    % DataA(s).L.abd.mvc={};
    DataA(s).L.kinIndex={};
    DataA(s).R.kinIndex={};
    DataA(s).L.kinLen={};
    DataA(s).R.kinLen={};
    DataA(s).L.emgLen=[];
    DataA(s).R.emgLen=[];
    DataA(s).R.flx.elbAng={};
    DataA(s).L.flx.elbAng={};
    
    
end
for n = 1:length(nameList)-2          %traverse each person
    DataA(n).name=nameList(n+2).name;
    
    index = ismember(nameXls,DataA(n).name);
    DataA(n).group = fmXls(index,1);
    DataA(n).FM = fmXls(index,2);
    
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
            if strcmp(typeList(j+2).name,'肌电')==1 && EMGFLAG
                t=zeros(1,8)+1;
                fileList=dir(fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name));
                lp=1;rp=1;
                for l=1:length(fileList)-2
                    
                    pathE{l}=fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name,fileList(l+2).name);
                    
                    if ~isempty(strfind(fileList(l+2).name,'motionL1'))
                        pathL{lp}=pathE{l};
                        
                        DataA(n).L.emgLen(lp)=loadEmgRow(pathL{lp});
                        lp=lp+1;
                        %                          for el=1:length(DataA(n).L.emgLen)
                        %                             for kl=1:length(DataA(n).L.kinLen)
                        %                                 for jl=1:length(DataA(n).L.kinLen{kl})
                        %                                     dl=abs(DataA(n).L.kinLen{kl}(jl)*20-DataA(n).L.emgLen{el})
                        %
                        %                                  end
                        %                              end
                        %                          end
                        %                          DataA(n).L.flx.sEMG=[DataA(n).L.flx.sEMG loadEmg(pathE)];
                        %                         elseif ~isempty(strfind(fileList(l+2).name,'motionL2'))
                        %                            DataA(n).L.abd.sEMG=[DataA(n).L.abd.sEMG loadEmg(pathE)];
                    elseif ~isempty(strfind(fileList(l+2).name,'motionR1'))
                        pathR{rp}=pathE{l};
                        
                        DataA(n).R.emgLen(rp)= loadEmgRow(pathE{l});
                        rp=rp+1;
                        %                            DataA(n).R.flx.sEMG=[DataA(n).R.flx.sEMG loadEmg(pathE{l})];
                        %                         elseif ~isempty(strfind(fileList(l+2).name,'motionR2'))
                        %                            DataA(n).R.abd.sEMG= [DataA(n).R.abd.sEMG loadEmg(pathE)];
                        %                         elseif ~isempty(strfind(fileList(l+2).name,'mvcR1'))
                        %                            DataA(n).R.flx.mvc= [DataA(n).R.flx.mvc loadEmg(pathE)];
                        %                         elseif ~isempty(strfind(fileList(l+2).name,'mvcR2'))
                        %                            DataA(n).R.abd.mvc=[DataA(n).R.abd.mvc loadEmg(pathE)];
                        %                         elseif (strfind(fileList(l+2).name,'mvcL1'))
                        %                            DataA(n).L.flx.mvc= [DataA(n).L.flx.mvc loadEmg(pathE)];
                        %                         elseif (strfind(fileList(l+2).name,'mvcL2'))
                        %                            DataA(n).L.abd.mvc= [DataA(n).L.abd.mvc loadEmg(pathE)];
                    end
                end
            end
            if strcmp(typeList(j+2).name,'运动')==1
                collTime=dir(fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name));
                pathNameR={};
                pathNameL={};
                resIndexL={};
                resIndexR={};
                dl={};
                dr={};
                dmr=[];
                dm=[];
                
                for k=1:length(collTime)-2          %traverse each data as 林翰飞2\右\运动\18-2014-12-10 16-10-18
                    
                    pathNameR=[pathNameR fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name,collTime(k+2).name,'Result.txt')];
                    if(side=='L')
                        [index,motion] = readRes(pathNameR{k});
                        resIndexL=[resIndexL index];
                        if ~isempty(index)
                            len=[index(1);diff(index)];
                            if motion=='1'
                                for kl=1:length(index)
                                    for el=1:length(DataA(n).L.emgLen)
                                        dl{k}(kl,el)=abs(len(kl)*20-DataA(n).L.emgLen(el));
                                    end
                                end
                                
                                DataA(n).L.kinIndex=[DataA(n).L.kinIndex index];   % the filed of kinIndex is the segment index by "运动康复训练结果" in Result.txt
                                DataA(n).L.kinLen=[DataA(n).L.kinLen len];
                                
                            elseif motion=='3'
                                dl{k}=nan;
                            end
                        elseif isempty(index)
                            dl{k}=nan;
                            resIndexL{k}=0;
                        end
                    elseif (side=='R')
                        [index,motion] = readRes(pathNameR{k});
                        resIndexR=[resIndexR index];
                        if ~isempty(index)
                            len=[index(1);diff(index)];
                            if motion=='1'
                                for kl=1:length(index)
                                    for el=1:length(DataA(n).R.emgLen)
                                        dr{k}(kl,el)=abs(len(kl)*20-DataA(n).R.emgLen(el));
                                    end
                                end
                                DataA(n).R.kinIndex=[DataA(n).R.kinIndex index];   % the filed of kinIndex is the segment index by "运动康复训练结果" in Result.txt
                                DataA(n).R.kinLen=[DataA(n).R.kinLen len];
                            elseif motion=='3'
                                dr{k}=nan;
                            end
                            
                        elseif  isempty(index)
                            dr{k}=nan;
                            resIndexR{k}=0;
                        end
                        
                    end
                end
                if(side=='L')
                    
                    for m=1:length(dl)
                        dm(m)=min(min(dl{m}));
                    end
                    if min(dm)<60
                        y= find(dm==min(dm));
                        [x,z]=find(dl{y}==min(dm),1);   %x is the row(kl), z is the column(el)
                        DataA(n).L.flx.sEMG=loadEmg(pathL{z});
                        [DataA(n).L.flx.shdAng,DataA(n).L.flx.elbAng]= loadAng(pathNameR{y},resIndexL{y},x);
                        
%                        pathNameR{y}
                    else
                        disp('Warnning! Can not find syn data!');
                        disp(fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name));
                        
                    end
                    
                end
                if(side=='R')
                    
                    for m=1:length(dr)
                        dmr(m)=min(min(dr{m}));
                    end
                    if min(dmr)<60
                        y= find(dmr==min(dmr));
                        [x,z]=find(dr{y}==min(dmr),1);   %x is the row(kl), z is the column(el)
                        DataA(n).R.flx.sEMG=loadEmg(pathR{z});
                        [DataA(n).R.flx.shdAng, DataA(n).R.flx.elbAng]= loadAng(pathNameR{y},resIndexR{y},x);
                        
%                        pathNameR{y}
                    else
                        disp('Warnning! Can not find syn data!');
                        disp(fullfile(oriPath,nameList(n+2).name,sideList(i+2).name,typeList(j+2).name));
                        % break;
                    end
                    
                end
            end
        end
    end
end

%


%                     if ~isempty(index)
%                         if ((side=='L')&&(motion=='1'))
%                            DataA(n).L.flx.kin= [DataA(n).L.flx.kin loadQuat(pathNameQ,index)];
%                         elseif ((side=='L')&&(motion=='3'))
%                            DataA(n).L.abd.kin= [DataA(n).L.abd.kin loadQuat(pathNameQ,index)];
%                         elseif ((side=='R')&&(motion=='1'))
%                            DataA(n).R.flx.kin= [DataA(n).R.flx.kin loadQuat(pathNameQ,index)];
%                         elseif ((side=='R')&&(motion=='3'))
%                            DataA(n).R.abd.kin= [DataA(n).R.abd.kin loadQuat(pathNameQ,index)];
%
%                         end
%                     end


