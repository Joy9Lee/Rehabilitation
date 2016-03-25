%Evaluate the signal's stableness
close all;
clear;
clc;
%addpath('../signalProcess')
load('../DATA/Sh3925');
load('../DATA/Tru3925');
Display = 1;
%% divide mildly set and severely set of affect
seve = [];
mild = [];
for i =1 : size(Sh.A.FM)
    if Sh.A.FM(i) < 30
        seve = [seve i];
    else
        mild = [mild i];
    end
end

%%Tru_balance
for i=1:length(Tru.A)
    TvarA(i) = var(Tru.A{i});
end

for i = 1:length(Tru.U)
    TvarU(i) = var(Tru.U{i});
end
TvarA = TvarA';
TvarU = TvarU';
[Mdata,Sdata,p] = diffAnaly2(log(TvarA(seve)),'Severely',log(TvarA(mild)),'Mildly',log(TvarU),'Control','躯干平稳度',Display);
[Mdata,Sdata,p] = diffAnaly(log(TvarA),'Affect',log(TvarU),'Control','躯干平稳度',Display);
[r,p] = corrAnaly(Sh.A.FM,'Fugl-Meyer评分',log(TvarA),'躯干平衡度',Display);

%% isometic analysis
for i=1:length(Sh.A.ang.met)
    meanA(i) = mean(Sh.A.ang.met{i});
    varA(i) = var(Sh.A.ang.met{i});
    axisA(i) = mean(var(Sh.A.axis.met{i}));
%     axisA(i) = mean(var([Sh.A.axis.met{i} Sh.A.ang.met{i}./100]));
%     jerkA(i) = mean(abs(diff(Sh.A.ang.met{i},3)));
end
meanA =meanA';
varA = varA';
axisA = axisA';
% stableA=(varA./meanA);

for i=1:length(Sh.U.ang.met)
    meanU(i) = mean(Sh.U.ang.met{i});
    varU(i) = var(Sh.U.ang.met{i});
    axisU(i) = mean(var(Sh.U.axis.met{i}));
%     jerkU(i) = mean(abs(diff(Sh.U.ang.met{i},3)));
end
varU=varU';
meanU =meanU';
axiU=log(axisU');
% jerkA = jerkA';
% stableU = (varU./meanU);

%%fix bug data
% varA([4 5 33]) = [4.3 4.5 4.8];
% axisA([5 33]) = [0.001 0.0015];
% jerkU = jerkU';
[Mdata,Sdata,p] = diffAnaly(meanA,'Affect',meanU,'Control','Range of motion',Display);
[r,p] = corrAnaly(Sh.A.FM,'Fugl-Meyer score',meanA,'Range of motion',Display);
[Mdata,Sdata,p] = diffAnaly2(log(axisA(seve)),'Severely',log(axisA(mild)),'Mildly',log(axisU),'Control','等长收缩旋转轴平稳度',Display);
[r,p] = corrAnaly(Sh.A.FM,'Fugl-Meyer评分',log(axisA),'旋转轴方差',Display);
[Mdata,Sdata,p] = diffAnaly2(log(varA(seve)),'Severely',log(varA(mild)),'Mildly',log(varU),'Control','等长收缩角度平稳度',Display);
[r,p] = corrAnaly(Sh.A.FM,'Fugl-Meyer评分',log(varA),'角度方差',Display);

%% isotonic analysis
for i=1:length(Sh.A.ang.ton)
    velocityA(i) = meanA(i)/length(Sh.A.ang.ton);
    angA{i} = Sh.A.ang.ton{i};
    jerkA(i) = mean(abs(diff(angA{i},3)));

end

for i=1:length(angA)
    xi1{i} = 1:length(Sh.A.axis.ton{i}(:,1));
    fit1{i}=polyfit(xi1{i}',Sh.A.axis.ton{i}(:,1),8);  
    yi1{i}=polyval(fit1{i},xi1{i});
end

for i=1:length(angA)
    xi2{i} = 1:length(Sh.A.axis.ton{i}(:,2));
    fit2{i}=polyfit(xi2{i}',Sh.A.axis.ton{i}(:,2),8);  
    yi2{i}=polyval(fit2{i},xi2{i});
end
for i=1:length(angA)
    xi3{i} = 1:length(Sh.A.axis.ton{i}(:,3));
    fit3{i}=polyfit(xi3{i}',Sh.A.axis.ton{i}(:,3),8);  
    yi3{i}=polyval(fit3{i},xi3{i});
end
for i=1:length(angA)
    JxAt(i) =  mean(abs(Sh.A.axis.ton{i}(:,1)-yi1{i}'))+mean(abs(Sh.A.axis.ton{i}(:,2)-yi2{i}'))+mean(abs(Sh.A.axis.ton{i}(:,3)-yi3{i}'));
end

%%One of the aixs fit condition
%  figure
% for i=1:length(angA)
%     subplot(5,7,i)  
%     hold on;
%     plot(xi1{i}',Sh.A.axis.ton{i}(:,1),xi1{i},yi1{i},'--r');
%     title(['FM=' num2str(Sh.A.FM(i))]);
% end 

%%The residual (original data - fit data)
% figure
% for i=1:length(angA)
%     subplot(5,7,i)  
%     hold on;
%     plot(Sh.A.axis.ton{i}(:,1)-yi1{i}');
%     title(['FM=' num2str(Sh.A.FM(i))]);
%     ylim([-0.2 0.2]);
% end 

velocityA = velocityA';
JxAt = JxAt';
% jerkA = jerkA';
for i=1:length(Sh.U.ang.ton)
    velocityU(i) = meanU(i)/length(Sh.U.ang.ton);
    angU{i} = Sh.U.ang.ton{i};
    jerkU(i) = mean(abs(diff(angU{i},3)));

end


for i=1:length(angU)
    xi1{i} = 1:length(Sh.U.axis.ton{i}(:,1));
    fit1{i}=polyfit(xi1{i}',Sh.U.axis.ton{i}(:,1),8);  
    yi1{i}=polyval(fit1{i},xi1{i});
end

for i=1:length(angU)
    xi2{i} = 1:length(Sh.U.axis.ton{i}(:,2));
    fit2{i}=polyfit(xi2{i}',Sh.U.axis.ton{i}(:,2),8);  
    yi2{i}=polyval(fit2{i},xi2{i});
end
for i=1:length(angU)
    xi3{i} = 1:length(Sh.U.axis.ton{i}(:,3));
    fit3{i}=polyfit(xi3{i}',Sh.U.axis.ton{i}(:,3),8);  
    yi3{i}=polyval(fit3{i},xi3{i});
end
for i=1:length(angU)
    JxUt(i) =  mean(abs(Sh.U.axis.ton{i}(:,1)-yi1{i}'))+mean(abs(Sh.U.axis.ton{i}(:,2)-yi2{i}'))+mean(abs(Sh.U.axis.ton{i}(:,3)-yi3{i}'));
end

velocityU = velocityU';
JxUt = JxUt';
% jerkU = jerkU';
%%fix bug data
% axisAt(34) = 0.03;

% jerk of axis
% figure;
% for i=1:length(Sh.A.ang.ton)
%     subplot(5,7,i)
%     plot(diff(Sh.A.axis.ton{i},3));
%     title(['FM=' num2str(Sh.A.FM(i))]);
%     ylim([-0.05 0.05]);
% end 
% figure;
% for i=1:length(Sh.U.ang.ton)
%     subplot(6,2,i)
%     plot(diff(Sh.U.axis.ton{i},3));
%         ylim([-0.05 0.05]);
% end 


[Mdata,Sdata,p] = diffAnaly(velocityA,'Affect',velocityU,'Control','运动速率',Display);
[r,p] = corrAnaly(Sh.A.FM,'Fugl-Meyer评分',velocityA,'运动速率',Display);
% [Mdata,Sdata,p] = diffAnaly(JxAt(seve),'Severely',JxAt(mild),'Mildly',JxUt,'Control',1);
[Mdata,Sdata,p] = diffAnaly(log(JxAt),'Affect',log(JxUt),'Control','运动平稳度',Display);
[r,p] = corrAnaly(Sh.A.FM,'Fugl-Meyer评分',log(JxAt),'旋转轴平稳度',Display);
% [Mdata,Sdata,p] = diffAnaly2(log(jerkA/meanA(i)),'Affect',log(jerkU/meanU(i)),'Control',1);
% [r,p] = corrAnaly(Sh.A.FM,'Fugl-Meyer评分',log(jerkA'/meanA(i)),'jerk',1);


%% regression analysis
n =35;
% X = [meanA  log(axisA) log(varA) velocityA log(JxAt) log(TvarA)];
X = [meanA  log(axisA) log(varA) velocityA  log(TvarA)];
Y = Sh.A.FM;
% X([4 6 26 33],:) = [];
% Y([4 6 26 33]) = [];
% index = rand(n,1);
% [a,b] = sort(index);
% X = X(b,:);
% Y = Sh.A.FM(b,:);
% X1 = X(1:24,:);
% X2 = X(25:end,:);
% Y1 = Y(1:24,:);
% Y2 = Y(25:end);
[ b , bint , r , rint , stats ]=regress ( Y , X ) ;
figure;
rcoplot(r,rint);
figure;
hist(r);
xlabel('Residuals');
ylabel('Frequency');
title('Residual Hist');
[r,p] = corrAnaly(Y,'Fugl-Meyer Score',Y+r,'Flexion FAS',1);
% [r,p] = corrAnaly(Y1,'Fugl-Meyer评分',Y1+r,'训练集',0);
% [r,p] = corrAnaly(Y2,'Fugl-Meyer评分',X2*b,'校验集',0);
% error = sum(abs(Y2 - X2*b))/length(Y2);
%% MD 
% for i=1:length(angA)
%     xi{i} = 1:length(angA{i});
%     fit{i}=polyfit(xi{i}',angA{i},4);  
%     yi{i}=polyval(fit{i},xi{i});
%     
% end

% filter = [1 2  4 5 6 7 10 11 12 13 14 15 16 17 18 19 20 21 22 23  24 28 29 30 31 32 33 34 ];
% angA=angA(filter);
% xi = xi(filter);
% yi = yi(filter);
% Sh.A.FM = Sh.A.FM(filter);

% figure
% for i=1:length(angA)
%     subplot(5,7,i)  
%     hold on;
%     plot(xi{i}',angA{i},xi{i},yi{i},'--r');
%     title(['FM=' num2str(Sh.A.FM(i))]);
% end 

% figure
% for i=1:length(angA)
%     subplot(5,7,i)  
%     hold on;
%     plot(Sh.A.axis.ton{i});
%     title(['FM=' num2str(Sh.A.FM(i))]);
% end 
% 
% figure
% for i=1:length(Sh.U.axis.ton)
%     subplot(6,2,i)  
%     hold on;
%     plot(Sh.U.axis.ton{i});
% end 


%  figure
%  plot(xi{7}',angA{7},xi{7},yi{7},'--r');
%   figure
%  plot(xi{5}',angA{5},xi{5},yi{5},'--r');

% for i=1:length(angU)
%     xiU{i} = 1:length(angU{i});
%     fitU{i}=polyfit(xiU{i}',angU{i},4);  
%     yiU{i}=polyval(fitU{i},xiU{i});
% end
% figure
% for i=1:length(angU)
%     subplot(6,2,i)  
% % for i=1:4
% %     subplot(2,2,i)  
%     hold on;
%     plot(xiU{i}',angU{i},xiU{i},yiU{i},'--r');
% end 
% for i=1:length(angA)
%     angA{i} = angA{i} - yi{i}';
%     varRedA(i) = var(angA{i});
% end
% % 2th fit
% for i=1:length(angA)
%     xi{i} = 1:length(angA{i});
%     fit{i}=polyfit(xi{i}',angA{i},6);  
%     yi{i}=polyval(fit{i},xi{i});
%     
% end
% 
% figure
% for i=1:length(angA)
%     subplot(5,7,i)  
%     hold on;
%     plot(xi{i}',angA{i},xi{i},yi{i},'--r');
%     title(['FM=' num2str(Sh.A.FM(i))]);
% end 
% 
% for i=1:length(angA)
%     angA{i} = angA{i} - yi{i}';
%     varRedA(i) = var(angA{i});
% end
% % 3th fit
% for i=1:length(angA)
%     xi{i} = 1:length(angA{i});
%     fit{i}=polyfit(xi{i}',angA{i},9);  
%     yi{i}=polyval(fit{i},xi{i});
%     
% end
% 
% figure
% for i=1:length(angA)
%     subplot(5,7,i)  
%     hold on;
%     plot(xi{i}',angA{i},xi{i},yi{i},'--r');
%     title(['FM=' num2str(Sh.A.FM(i))]);
% end 
% 
% for i=1:length(angA)
%     angA{i} = angA{i} - yi{i}';
%     varRedA(i) = var(angA{i});
% end

% for i=1:length(angU)
%     angU{i} = angU{i} - yiU{i}';
%     varRedU(i) = var(angU{i});
% end
% 
% 
% 
% [Mdata,Sdata,p] = diffAnaly(log(varRedA(seve)),'Severely',log(varRedA(mild)),'mildly',log(varRedU),'Control',1);
% [r,p] = corrAnaly(Sh.A.FM,'Fugl-Meyer评分',log(varRedA'),'var',1);
%% envelope
% for i=1:length(angA)
% 
%     [upper{i},lower{i}] = envelope(xi{i}',angA{i});  
%     mean_ul{i} = (upper{i} + lower{i})/2;%spline mean of upper and lower
%     residual{i} = angA{i}-mean_ul{i}; 
%     
% end




% for i=1:length(angA)
%     xsize=length(angA{i});
%     angA{i} = angA{i}-(1:length(angA{i}))';
%     dd=1:1:xsize;
%     [spmax, spmin, flag]=extrema(angA{i});  %call function extrema 
%     %the usage of  spline ,please see part11.  
%     upper{i}= spline(spmax(:,1),spmax(:,2),dd); %upper spline bound of this sift 
%     lower{i}= spline(spmin(:,1),spmin(:,2),dd); %lower spline bound of this sift 
%     mean_ul{i} = (upper{i} + lower{i})/2;%spline mean of upper and lower
%     residual{i} = angA{i}-mean_ul{i}'; 
%     
% end

% figure
% for i=1:length(angA)
%     subplot(5,7,i)  
%     plot(angA{i});
%     ylim([-5 5]);
%     title(['FM=' num2str(Sh.A.FM(i))]);
% end


% figure
% for i=1:length(angA)
%     subplot(5,7,i)
% % for i=1:4
% %     subplot(2,2,i)  
%     hold on;
%     plot(angA{i});
%     plot(upper{i},'--r');
%     plot(lower{i},'--g');
%     hold off
%     ylim([-20 20]);
%     title(['FM=' num2str(Sh.A.FM(i))]);
% end
% figure
% for i=1:length(angA)
%     subplot(5,7,i)
% % for i=1:4
% %     subplot(2,2,i)  
%     plot(mean_ul{i});
%     ylim([-10 10]);
%     title(['FM=' num2str(Sh.A.FM(i))]);
% end
% 
% 
% figure
% for i=1:length(angA)
%     subplot(5,7,i)
%     plot(residual{i});
%     title(['FM=' num2str(Sh.A.FM(i))]);
% end

%% EMD
% figure(1)
% for i=1:length(Sh.A.ang.ton)
%         rslt{i}=eemd(angA{i},0,1)
%     subplot(5,7,i)    
%     plot(angA{i});
%     title(['FM=' num2str(Sh.A.FM(i))]);
% end
% figure(2)
% for i=1:length(Sh.A.ang.ton)
%     subplot(5,7,i)    
%     hold on;
%     plot(rslt{i}(:,2));
%     plot(rslt{i}(:,3)-20,'g');
%     plot(rslt{i}(:,4)-40,'r');
%     plot(sum(rslt{i}(:,5:end),2)-60,'m');
%     hold off
%     title(['FM=' num2str(Sh.A.FM(i))]);
%     ylim([-50 50]);
% end
% figure(3)
% for i=1:length(Sh.A.ang.ton)
%     subplot(5,7,i)    
%     plot(rslt{i}(:,2));
%     title(['FM=' num2str(Sh.A.FM(i))]);
% end
% figure(4)
% for i=1:length(Sh.A.ang.ton)
%     omega{i} = ifndq(rslt{i}(:,2),1)
%     subplot(5,7,i)    
%     plot(omega{i});
%     title(['FM=' num2str(Sh.A.FM(i))]);
% end