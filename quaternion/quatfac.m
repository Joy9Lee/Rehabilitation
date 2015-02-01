function [scale aixs]=quatfac(quat)
%% factotization the quaternions, calculate aixs and angle

N=length(quat);
scale = quat(:,4);
aixs = quat(:,1:3)./[sqrt(ones(N,1)-scale.^2) sqrt(ones(N,1)-scale.^2) sqrt(ones(N,1)-scale.^2)];