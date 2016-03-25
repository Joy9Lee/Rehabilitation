close all; clear; clc;
%第一步：输入样本矩阵%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data=rand(10,8)+randn(10,8)+ones(10,8);
%现对其进行pca降维
%%
%第二步：计算样本中每一维的均值，然后计算观察值与均值之间的偏差，再计算协方差矩阵
data=bsxfun(@minus,data,mean(data));%对样本矩阵去均值
C=data'*data;
C=C./(size(data,1)-1);%根据协方差公式计算协方差，得到协方差矩C

%第三步：计算协方差矩阵的特征值和特征向量矩阵
fprintf(1,'Calculating generalized eigenvectors and eigenvalues...\n');
[eigvectors, eigvalues] = eig(C);%eigvectors为特征向量组成的矩阵，eigvalues特征值组成的对角矩阵
fprintf(1,'Sorting eigenvectors according to eigenvalues...\n');
d1=diag(eigvalues);%返回矩阵对角线上的值，为列向量。
[dsort index]=sort(d1,'descend'); %以降序排序，dsort为排列后的值，index为索引值
vsort=eigvectors(:,index); %将特征向量按照特征值大小按列排序

%第四步：计算总能量，并选取贡献率最大的特征值
dsum=sum(d1); %对所有的特征值求和
dsum_extract = 0;%求前几个特征值之和,当前几个特征值之和大于90%时，可以认为这几个特征值可以表征当前矩阵
p = 0;
while( dsum_extract/dsum < 0.9)
p = p + 1;
dsum_extract = sum(dsort(1:p));
end


%第五步：计算前p个特征值所对应的的特征向量组成的矩阵，计算降维后的样本矩阵
vsort = vsort(:,1:p);%提取前p列特征向量获得d*p矩阵
fprintf(1,'Feature extraction and calculating newData...\n');
newdata=data*vsort;%生成N行p列的矩阵，达到降维的效果