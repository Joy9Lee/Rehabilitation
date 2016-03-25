close all; clear ; clc;
Hn=rand(9,7);
H1=rand(4,7);
 for j=1:4
     m=lsqnonneg(Hn',H1(j,:)');
 end
   