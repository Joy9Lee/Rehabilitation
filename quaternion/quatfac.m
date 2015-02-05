function [ang aixs]=quatfac(quat)
%factotization the quaternions, calculate aixs and angle
% input is a quaternions matrix,each row is a quaternion.
PI = 3.1415;
N=length(quat);
scale = quat(:,1);
aixs = quat(:,2:4)./[sqrt(ones(N,1)-scale.^2) sqrt(ones(N,1)-scale.^2) sqrt(ones(N,1)-scale.^2)];
ang = acos(scale)*2/PI*180;