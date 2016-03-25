function [W,H,R,D]=ExtractSynergy(data,N,maxiter,rep,varargin)
%Extracting Muscle Synergies
%   [W,H]=ExtractSynergy(data,N)  
%   [W,H]=ExtractSynergy(data,N,'d') Display by figure  
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

%% Variables for testing
% 
% close all; clear; clc;
% load('../DATA/SynDataA_35');
% t=19;
% SynDataA.EMG{t}=PreProcess(SynDataA.EMG{t});
% data=SynDataA.EMG{t}';
% rep=5;
% Display = 1;
% maxiter=1000;
% N=3;

%% Nonegative matrix factorization
[m,n]=size(data);
% opt = statset('MaxIter',maxiter,'Display','final');
 opt = statset('MaxIter',maxiter);

w0=unifrnd(0,1,[m,N]);
h0=unifrnd(0,1,[N,n]);
[W,H,D]=nnmf(data,N,'w0',w0,'h0',h0,'algorithm','mult','options',opt,'replicates',rep);

%% Reconstruction rate compute
M=data-W*H;
R=1-sum(sum(M.^2))/sum(sum(data.^2));
% R=1-sqrt(sum(sum(M.^2))/sum(sum(data.^2)));
%% Display
if Display
    figure
    for i=1:N
        subplot(N,1,i)
        plot(H(i,:));
        ylim([0 0.4])
        
    end

    figure
    for i=1:N
        subplot(1,N,i);
        barh(W(:,i)/8);
        xlim([0 1])
    end
 end