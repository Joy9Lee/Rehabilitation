function rawdata=DirTraversal(pathname)    
% Traversal of the directory
%form of files is .mat
%% 
nameList = dir(fullfile(pathname));
for n = 1:length(nameList)-2
    timelist=dir(fullfile(pathname,nameList(n+2).name));
    for i=1:length(timelist)-2
        data(i)=load(fullfile(pathname,nameList(n+2).name,timelist(i+2).name));
        rawdata{i}=data(i).datablock1.data;
    end
end
end