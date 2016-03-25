clc
close all
clear 
addpath('G:\SNARC\Rehabilitation\SignalProcess');
load('G:\SNARC\Rehabilitation\DATA\SynDataU25_quat');
load('G:\SNARC\Rehabilitation\DATA\SynDataA39_quat');
 [SynDataA.loc0,SynDataA.loc1]=subsection(SynDataA,1);

[SynDataA.loc0u,SynDataA.loc1u]=subsectionL(SynDataA,1);



[SynDataU.loc0,SynDataU.loc1]=subsection(SynDataU,1);
[SynDataU.loc0l,SynDataU.loc1l]=subsectionL(SynDataU,1);

SynDataA.loc0=SynDataA.loc0';
SynDataA.loc1=SynDataA.loc1';
SynDataA.loc0u=SynDataA.loc0u';
SynDataA.loc1u=SynDataA.loc1u';
SynDataU.loc0=SynDataU.loc0';
SynDataU.loc1=SynDataU.loc1';
SynDataU.loc0l=SynDataU.loc0l';
SynDataU.loc1l=SynDataU.loc1l';