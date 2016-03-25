function [coeff,score,latent,r]=mypca(indata,N,varargin)
error(nargchk(2,3,nargin));
if nargin ==3 && varargin{1}==1
    Display = 1;
else
    Display = 0;
end
[coeff,score,latent]=pca(indata);
r=cumsum(latent)./sum(latent);   
if Display
    figure
    for i=1:N
        subplot(1,N,i);
        barh(coeff(i,:));
    end
end