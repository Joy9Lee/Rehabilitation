clc;
clear;
close all;
load('../DATA/Sh');
load('../DATA/Tru');

[temp index] = sort(Sh.A.FM);

Sh1.A.ang.ton = Sh.A.ang.ton(index);
Sh1.A.ang.met = Sh.A.ang.met(index);
Sh1.A.axis.ton = Sh.A.axis.ton(index);
Sh1.A.axis.met = Sh.A.axis.met(index);
Sh1.A.FM = Sh.A.FM(index);
Sh1.U = Sh.U;

[temp index] = sort(Sh.A.FM);
Tru.A = Tru.A(index);
Tru.FM = Tru.FM(index);
Tru.U = Tru.U;
figure;
for i = 1:length(Sh1.A.FM)
    subplot(5,7,i)
    plot(Sh.A.ang.ton{i});
     title(['FM=' num2str(Sh.A.FM(i))]);
end

figure;
for i = 1:length(Sh1.A.FM)
    subplot(5,7,i)
    plot(Sh1.A.ang.ton{i});
     title(['FM=' num2str(Sh1.A.FM(i))]);
end
