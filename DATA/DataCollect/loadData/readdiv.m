function [divS,divE] = readdiv(path,index,kl)
%readRes read the Motion capture data in Result.txt, return the segment index and the motion
%number.
%   path is the file path.
%   index is the segment mark for quatnions file.
%   motion is the motion mark, 1 indicate the flextion,and 3 indicate the abduction.
%%
% close all; clear all; clc;
% RES_LENGTH = 33;    
% kl=3;
%  count=0;
% index=[224;447;678];%the length of result segment               
%path='G:\SNARC\DATA\患者组\常来福\右患\运动\18-2014-8-22 11-27-26\Result.txt';
DATA = importdata(path); %load data
if kl==1
    str1 = DATA.textdata(index(kl)+9);    %前臂 肘与腕之间
     [tokenE,remE] = strtok(str1{1},'：');
    divE = str2num(remE(2:end));
     str2 = DATA.textdata(index(kl)+19);    %上臂 肘与腕之间
     [tokenS,remS] = strtok(str2{1},'：');
    divS = str2num(remS(2:end));
else 
    str1 = DATA.textdata(index(kl)+33*(kl-1)+9);    %前臂 肘与腕之间
     [tokenE,remE] = strtok(str1{1},'：');
    divE = str2num(remE(2:end));
     str2 = DATA.textdata(index(kl)+33*(kl-1)+19);    %上臂 肘与腕之间
     [tokenS,remS] = strtok(str2{1},'：');
    divS = str2num(remS(2:end));
end