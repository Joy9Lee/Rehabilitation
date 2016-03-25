% RGB = imread('peppers.png');
% imshow(RGB)
% I = rgb2gray(RGB);
% figure
% imshow(I)
% str='F:\code\matlab\face\face'; %图像存放路径
close all;clear ;clc
S=0.0;%行向量
dis=zeros(1,100,'double');%每一个人脸跟平均脸的距离
%b=zeros(2700,400,'double');%人脸向量矩阵
for i=1
   % B=imread([str,num2str(i),'.bmp']); %依次读取每一幅图像
   B = imread('peppers.png');
    m = size(B, 3);
    if m==1
     I = B;   
    else
      I=rgb2gray(B);   
    end
%在此处进行你的图像处理即可
A = I';%I的转置
C = A(:)';%矩阵转换为行向量，即一张图片对应一个行向量
b(i,:)=C;
%S = S+C;
end
Avg=mean(b);%平均脸
%%
%显示平均脸
AvgImg = reshape(Avg,20,20)';
AvgImgInt=uint8(AvgImg);
imshow(AvgImgInt)%显示平均脸




%%  
%使用PCA分析b
[coef,score,latent,t2] = princomp(b);
%% 
% 通过latent,可以知道提取前几个主成分就可以了.
figure(1);
percent_explained = 100*latent/sum(latent);
pareto(percent_explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
print -djpeg 2;

%选取前10个主特征组成新的特征空间
pca10 = coef(:,1:10);
%%
%人脸的读取及重构
facestr='F:\code\matlab\face\'; %图像存放路径
faceagr=zeros(100,10,'double');%每一张非人脸图像映射到特征空间的系数
for i=1:2700
   faceagr(i,:) = (b(i,:)-Avg)*pca10; 
end

for i=1:2700
faceImg(i,:)=Avg+(pca10*(faceagr(i,:)'))';%人脸图像图像重构
faceJuli(i)=norm(b(i,:)-faceImg(i,:));
end
avgJuli = mean(faceJuli);
%分布图
figure(2);
faceymin=min(faceJuli);
faceymax=max(faceJuli);
facex=linspace(faceymin,faceymax,20);  %将最大最小区间分成20个等分点(19等分),然后分别计算各个区间的个数
faceyy=hist(faceJuli,facex);  %计算各个区间的个数
faceyy=faceyy/length(faceJuli); %计算各个区间的个数
bar(facex,faceyy) %画出概率密度分布图



%%
%非人脸的读取及重构
nofacestr='F:\code\matlab\noface\'; %图像存放路径
b1=zeros(4300,400,'double');%非人脸向量矩阵
for i=1:4300
    B1=imread([nofacestr,num2str(i),'.bmp']); %依次读取每一幅图像
    m = size(B1, 3);
    if m==1
     I1 = B1;   
    else
      I1=rgb2gray(B1);   
    end
%在此处进行你的图像处理即可
A1 = I1';%I的转置
C1 = A1(:)';%矩阵转换为行向量，即一张图片对应一个行向量
b1(i,:)=C1;
%S = S+C;
end
%非人脸的映射

bb1=zeros(1000,10,'double');%每一张非人脸图像映射到特征空间的系数
for i=1:1000
   bb1(i,:) = (b1(i,:)-Avg)*pca10; 
end


for i=1:1000
nofaceImg(i,:)=Avg+(pca10*(bb1(i,:)'))';%非人脸图像重构
nofaceJuli(i)=norm(b1(i,:)-nofaceImg(i,:));
end
nofaceavgJuli = mean(nofaceJuli);
figure(3);
nofaceymin=min(nofaceJuli);
nofaceymax=max(nofaceJuli);
nofacex=linspace(nofaceymin,nofaceymax,20);  %将最大最小区间分成20个等分点(19等分),然后分别计算各个区间的个数
nofaceyy=hist(nofaceJuli,nofacex);  %计算各个区间的个数
nofaceyy=nofaceyy/length(nofaceJuli); %计算各个区间的个数
bar(nofacex,nofaceyy) %画出概率密度分布图

%Img=reshape(X1,20,20)';
%ImgInt=uint8(Img);
%imshow(ImgInt)


