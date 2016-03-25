function [m, A, Eigenfaces] = EigenfaceCore(T)
% 用PCA原理决定人脸图像的最优特征，得到一个二维矩阵，包含训练图像向量，返回三个输出
% 参数:T包含训练集中所有的图像信息集合，      
% 返回值：m：(M*Nx1)训练均值;Eigenfaces：(M*Nx(P-1))训练集协方差矩阵的特征向量；A：(M*NxP) 每一张图像与均值图像的方差矩阵
m = mean(T,2); % 平均图像/行平均（每一副图像的对应象素求平均）m=(1/P)*sum(Tj's) (j=1 : P)
Train_Number = size(T,2);%列数
%计算机每一张图片到均值图像的方差
A = [];  
for i = 1 : Train_Number%对每一列
    temp = double(T(:,i))-m; %每一张图与均值的差异
    A = [A temp]; %方差矩阵
end
%降维
L = A'*A; % L是协方差矩阵C=A*A'的转置.
[V D] = eig(L); %对角线上的元素是L|C的特征值.V:以特征向量为列的满秩矩阵，D：特征值对角矩阵。即L*V = V*D.
L_eig_vec = [];%特征值向量
for i = 1 : size(V,2)%对每个特征向量
    if( D(i,i)>1 )%特征值大于1时
        L_eig_vec = [L_eig_vec V(:,i)];%集中对应的特征向量
    end
end
Eigenfaces = A * L_eig_vec; % 计算机协方差矩阵C的特征向量，得到降维了的特征,A为每一张图像与均值图像的方差构成的矩阵，