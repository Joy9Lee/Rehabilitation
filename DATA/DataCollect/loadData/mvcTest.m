close all
clear all
clc
trapPath = 'G:\SNARC\mvcEMG\songjianmvc.ASC';
delPath = 'G:\SNARC\mvcEMG\qianqumvc.ASC';
%emgPath = 'G:\SNARC\mvcEMG\waizhankuai.ASC';
emgPath = 'G:\SNARC\mvcEMG\qianqu2.ASC';
flx= loadEmg(emgPath);
trpmvc= loadEmg(trapPath);
delmvc=loadEmg(delPath);

%legend('1','2','3','4','5','6','7','8','9','10','11')
rmvc=max(winRMS(trpmvc(:,1:7),20));
%rmvc=max(winRMS(delmvc(:,1:7),20));
rEMG=winRMS(flx(3:end,1:7),20);
ratio=rEMG(:,2)./rmvc(2);
%ratio=rEMG(:,3)./rmvc(3)*100;
plot(ratio)
title('健康人三角肌前组肌电信号归一化值')
ylabel('归一化值%')

%plot(rEMG(:,2))
%plot(flx(:,2))