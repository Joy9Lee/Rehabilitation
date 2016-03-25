function [index,motion] = readRes(path)
%readRes read the Motion capture data in Result.txt, return the segment index and the motion
%number.
%   path is the file path.
%   index is the segment mark for quatnions file.
%   motion is the motion mark, 1 indicate the flextion,and 3 indicate the abduction.
%%
% close all; clear all; clc;
RES_LENGTH = 33;                                    %the length of result segment               
%path='G:\SNARC\DATA\新正常组\龚玉贞\左\运动\17-2015-4-28 18-11-29\Result.txt';
%path2='G:\SNARC\DATA\新正常组\陈贵存\右\运动\18-2015-5-2 11-36-0\Result.txt';

DATA = importdata(path); %load data
%DATA = importdata(path2); %load data
if isempty(DATA)
    disp('Warnning! Datafile is empty!.');
    disp(path);
    index=0;
    motion='0';
    return
end
mark = strcmp(DATA.textdata, '运动康复训练结果');     %mark the key location
index = find(mark==1);
if isempty(index)                                       %no evaluative result
     disp('Warnning! NO marker.');
     disp(path);
     motion='0';
else
    str = DATA.textdata(index(1)+1);
    str = str{1};                                       %unpack the cell
    motion = str(regexp(str,'\d'));
    N = length(index);
    for i = 1:N                                         %caculate the index for quatnions files
        index(i)=index(i)-RES_LENGTH*(i-1)-1;
    end
end