function [ang aixs]=quatfac(quat)
%factotization the quaternions, calculate aixs and angle
% input is a quaternions matrix,each row is a quaternion.
PI = 3.1415;
N=length(quat);
scale = quat(:,4);
aixs = quat(:,1:3)./[sqrt(ones(N,1)-scale.^2) sqrt(ones(N,1)-scale.^2) sqrt(ones(N,1)-scale.^2)];
ang = acos(scale)*2/PI*180;