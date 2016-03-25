% RGB = imread('peppers.png');
% imshow(RGB)
% I = rgb2gray(RGB);
% figure
% imshow(I)
% str='F:\code\matlab\face\face'; %ͼ����·��
close all;clear ;clc
S=0.0;%������
dis=zeros(1,100,'double');%ÿһ��������ƽ�����ľ���
%b=zeros(2700,400,'double');%������������
for i=1
   % B=imread([str,num2str(i),'.bmp']); %���ζ�ȡÿһ��ͼ��
   B = imread('peppers.png');
    m = size(B, 3);
    if m==1
     I = B;   
    else
      I=rgb2gray(B);   
    end
%�ڴ˴��������ͼ������
A = I';%I��ת��
C = A(:)';%����ת��Ϊ����������һ��ͼƬ��Ӧһ��������
b(i,:)=C;
%S = S+C;
end
Avg=mean(b);%ƽ����
%%
%��ʾƽ����
AvgImg = reshape(Avg,20,20)';
AvgImgInt=uint8(AvgImg);
imshow(AvgImgInt)%��ʾƽ����




%%  
%ʹ��PCA����b
[coef,score,latent,t2] = princomp(b);
%% 
% ͨ��latent,����֪����ȡǰ�������ɷ־Ϳ�����.
figure(1);
percent_explained = 100*latent/sum(latent);
pareto(percent_explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
print -djpeg 2;

%ѡȡǰ10������������µ������ռ�
pca10 = coef(:,1:10);
%%
%�����Ķ�ȡ���ع�
facestr='F:\code\matlab\face\'; %ͼ����·��
faceagr=zeros(100,10,'double');%ÿһ�ŷ�����ͼ��ӳ�䵽�����ռ��ϵ��
for i=1:2700
   faceagr(i,:) = (b(i,:)-Avg)*pca10; 
end

for i=1:2700
faceImg(i,:)=Avg+(pca10*(faceagr(i,:)'))';%����ͼ��ͼ���ع�
faceJuli(i)=norm(b(i,:)-faceImg(i,:));
end
avgJuli = mean(faceJuli);
%�ֲ�ͼ
figure(2);
faceymin=min(faceJuli);
faceymax=max(faceJuli);
facex=linspace(faceymin,faceymax,20);  %�������С����ֳ�20���ȷֵ�(19�ȷ�),Ȼ��ֱ�����������ĸ���
faceyy=hist(faceJuli,facex);  %�����������ĸ���
faceyy=faceyy/length(faceJuli); %�����������ĸ���
bar(facex,faceyy) %���������ܶȷֲ�ͼ



%%
%�������Ķ�ȡ���ع�
nofacestr='F:\code\matlab\noface\'; %ͼ����·��
b1=zeros(4300,400,'double');%��������������
for i=1:4300
    B1=imread([nofacestr,num2str(i),'.bmp']); %���ζ�ȡÿһ��ͼ��
    m = size(B1, 3);
    if m==1
     I1 = B1;   
    else
      I1=rgb2gray(B1);   
    end
%�ڴ˴��������ͼ������
A1 = I1';%I��ת��
C1 = A1(:)';%����ת��Ϊ����������һ��ͼƬ��Ӧһ��������
b1(i,:)=C1;
%S = S+C;
end
%��������ӳ��

bb1=zeros(1000,10,'double');%ÿһ�ŷ�����ͼ��ӳ�䵽�����ռ��ϵ��
for i=1:1000
   bb1(i,:) = (b1(i,:)-Avg)*pca10; 
end


for i=1:1000
nofaceImg(i,:)=Avg+(pca10*(bb1(i,:)'))';%������ͼ���ع�
nofaceJuli(i)=norm(b1(i,:)-nofaceImg(i,:));
end
nofaceavgJuli = mean(nofaceJuli);
figure(3);
nofaceymin=min(nofaceJuli);
nofaceymax=max(nofaceJuli);
nofacex=linspace(nofaceymin,nofaceymax,20);  %�������С����ֳ�20���ȷֵ�(19�ȷ�),Ȼ��ֱ�����������ĸ���
nofaceyy=hist(nofaceJuli,nofacex);  %�����������ĸ���
nofaceyy=nofaceyy/length(nofaceJuli); %�����������ĸ���
bar(nofacex,nofaceyy) %���������ܶȷֲ�ͼ

%Img=reshape(X1,20,20)';
%ImgInt=uint8(Img);
%imshow(ImgInt)


