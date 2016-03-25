function [W,H,R,D]=ExtractSynergyold(data,N,maxiter,rep,varargin)
%Extracting Muscle Synergies
%   [H,R]=ExtractSynergy(data,N)  
%   [H,R]=ExtractSynergy(data,N,'d') Display by figure  
%    maxiter : Maximum number of iterations to run
%   data is the preprocessed sEMG signal and N is the number of muscle
%   varargin is the reloading argument.
%   Add argument 'd' to display the figure.
%   synergies extracting.
%   H is a  time-invariant, nonnegative vector in muscle space denoting the
%   ith muscle synergy and R is the sEMG reconstruction rate.

%% reloading function
error(nargchk(4,5,nargin));
if nargin ==5 && varargin{1}==1
    Display = 1;
else
    Display = 0;
end


 addpath('G:\SNARC\Rehabilitation\MusSynergy\nmf_toolbox')
%% Initailization
% close all; clear; clc;
% Display = 1;
% maxiter=1000;
% N=3;
% 
% load('../DATA/SynDataA_35');
% t=16;
% SynDataA.EMG{t}=PreProcess(SynDataA.EMG{t});
% data=SynDataA.EMG{t};
% rep=5;
%% Nonegative matrix factorization
%while(abs(R-R1)<0.0001)
%  [W,H]=nmf_mm(data,N,maxiter,1);
% if Display
%     opt = statset('MaxIter',20,'Display','final');
% else
%opt = statset('MaxIter',maxiter,'Display','final');
[m,n]=size(data);
 opt = statset('MaxIter',maxiter);
% % end
w0=unifrnd(0,1,[m,N]);
h0=unifrnd(0,1,[N,n]);
[W,H,D]=nnmf(data,N,'w0',w0,'h0',h0,'algorithm','mult','options',opt,'replicates',rep);
% [W,H,D]=nnmf(data,N,'algorithm','mult','options',opt,'replicates',5);
M=data-W*H;
%Reconstruction rate compute
 R=1-sum(sum(M.^2))/sum(sum(data.^2));
 %R=1-sqrt(sum(sum(M.^2))/sum(sum(data.^2)));

%% Display
if Display
    figure
    for i=1:N
        subplot(N,1,i)
        plot(W(:,i));
    end

    figure
    for i=1:N
        subplot(1,N,i);
        barh(H(i,:));
    end
 end