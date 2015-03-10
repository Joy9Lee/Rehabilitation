close all;
clear;
clc;
load('../DATA/mCurveA');
load('../DATA/mCurveU');
PART = 2;
for i = 1:length(mCurveA)
    angA{i} = mCurveA(i).angA{PART}/90;
end

% figure
% for i=1:length(angA)
%     subplot(5,7,i)  
%     plot(angA{i});
% %     title(['FM=' num2str(Sh.A.FM(i))]);
% end 

for i=1:length(angA)
    xi{i} = 1:length(angA{i});
    fit{i}=polyfit(xi{i}',angA{i},12);  
    yi{i}=polyval(fit{i},xi{i});
end
figure
% for i=1:length(angA)
%     subplot(5,7,i)  
for i=1:16
    subplot(4,4,i)  
    hold on;
    plot(xi{i}',angA{i},xi{i},yi{i},'--r');
%     title(['FM=' num2str(Sh.A.FM(i))]);
end 

for i=1:length(yi)
    xi2{i} = 1:length(yi{i});
    fit2{i}=polyfit(xi2{i},yi{i},4);  
    yi2{i}=polyval(fit2{i},xi2{i});
end
figure
for i=1:16
    subplot(4,4,i)  
    hold on;
    plot(xi{i}',angA{i},xi{i},yi2{i},'--r');
%     title(['FM=' num2str(Sh.A.FM(i))]);
end 