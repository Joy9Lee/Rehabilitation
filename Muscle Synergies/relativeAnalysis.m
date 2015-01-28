x2= [0.9500    0.5400    0.8100    0.9100    0.8600  0.4600	0.8200    0.9500    0.9500    0.9300 ];
x3= [0.8300    0.8600    0.8000    0.7800    0.7400  0.7400	0.7300    0.9200    0.9700    0.9900];
x4= [0.9900    0.9700    0.8000    0.7700    0.9200    0.9200 0.5900    0.9600    0.8300    0.9600];
y = [ 37    19    48    16    51    57    12    28    63    56];

s='R=';

figure(1);
[r,p1]=corr(x4',y');
r1=corrcoef(x4,y);
p=polyfit(x4,y,1);
x1=linspace(min(x4),max(x4));
y1=polyval(p,x1);
plot(x4,y,'*',x1,y1);
r1=r1(1,2);
r1=num2str(r1');
p1=num2str(p1');
s1=strcat('N=4','   R=',r1,'   P=',p1);
xlabel('肌肉协同相似度');
ylabel('Fugl-Meyer Score');
title(s1);

figure(2);
[r,p2]=corr(x3',y');
r2=corrcoef(x3,y);
p=polyfit(x3,y,1);  
x1=linspace(min(x3),max(x3));  
y1=polyval(p,x1);  
plot(x3,y,'*',x1,y1);  
r2=r2(1,2);
p2=num2str(p2);
r2=num2str(r2');
s2=strcat('N=3','   R=',r2,'   P=',p2);
xlabel('肌肉协同相似度');
ylabel('Fugl-Meyer Score');
title(s2);

figure(3);
r3=corrcoef(x2,y);
p=polyfit(x2,y,1);  
x1=linspace(min(x2),max(x2));  
y1=polyval(p,x1);  
plot(x2,y,'*',x1,y1);  
r3=r3(1,2);
r3=num2str(r3');
s3=strcat('N=2####',s,r3);
title(s3);