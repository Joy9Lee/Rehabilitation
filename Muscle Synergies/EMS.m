% function [H,R]=EMS(data,N,varargin)
% %Extracting Muscle Synergies
% %   [H,R]=EMS(data,N)  
% %   [H,R]=EMS(data,N,'d') Display by figure  
% %   data is the preprocessed sEMG signal and N is the number of muscle
% %   varargin is the reloading argument.
% %   Add argument 'd' to display the figure.
% %   synergies extracting.
% %   H is a  time-in-variant nonnegative vector in muscle space denoting the
% %   ith muscle synergy and R is the sEMG reconstruction rate.
% 
% %% reloading function
% error(nargchk(2,3,nargin));
% if nargin ==3 && varargin{1}=='d'
%     Display = 1;
% else
%     Display = 0;
% end
close all; clear; clc;
data=rand(144533,7);
%% Initailization
[m,n]=size(data);
Display = 1;
maxiter=20;
N=7;

%% Initailization
[m,n]=size(data);
num=m*n;
R=0;
%% Nonegative matrix factorization
X = rand(m,20)*rand(20,n);
opt = statset('MaxIter',5,'Display','final');
[W0,H0] = nnmf(X,N,'replicates',10,'options',opt,'algorithm','mult');
opt = statset('MaxIter',1000,'Display','final');
%[W,H] = nnmf(data,N,'options',opt,'algorithm','mult');

[W,H] = nnmf(data,N,'w0',W0,'h0',H0,'options',opt,'algorithm','mult','replicates',20);
% D=0;
% while(D<0.8)
% opt = statset('MaxIter',20,'Display','final');
% [W,H,D]=nnmf(data,4,'options',opt,'replicates',20);
% end
%R=D/sqrt(norm(data,'fro')/num);
M=data-W*H;
D1=norm(data-W*H);
D2=norm(data);
% R=norm(data-W*H)/norm(data);
%Reconstruction rate compute
%R=1-sqrt(sum(M.^2)/sum(data.^2));
R=1-sum(sum(M.^2))/sum(sum(data.^2));

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