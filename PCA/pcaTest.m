close all; clear; clc;
%��һ����������������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data=rand(10,8)+randn(10,8)+ones(10,8);
%�ֶ������pca��ά
%%
%�ڶ���������������ÿһά�ľ�ֵ��Ȼ�����۲�ֵ���ֵ֮���ƫ��ټ���Э�������
data=bsxfun(@minus,data,mean(data));%����������ȥ��ֵ
C=data'*data;
C=C./(size(data,1)-1);%����Э���ʽ����Э����õ�Э�����C

%������������Э������������ֵ��������������
fprintf(1,'Calculating generalized eigenvectors and eigenvalues...\n');
[eigvectors, eigvalues] = eig(C);%eigvectorsΪ����������ɵľ���eigvalues����ֵ��ɵĶԽǾ���
fprintf(1,'Sorting eigenvectors according to eigenvalues...\n');
d1=diag(eigvalues);%���ؾ���Խ����ϵ�ֵ��Ϊ��������
[dsort index]=sort(d1,'descend'); %�Խ�������dsortΪ���к��ֵ��indexΪ����ֵ
vsort=eigvectors(:,index); %������������������ֵ��С��������

%���Ĳ�����������������ѡȡ��������������ֵ
dsum=sum(d1); %�����е�����ֵ���
dsum_extract = 0;%��ǰ��������ֵ֮��,��ǰ��������ֵ֮�ʹ���90%ʱ��������Ϊ�⼸������ֵ���Ա�����ǰ����
p = 0;
while( dsum_extract/dsum < 0.9)
p = p + 1;
dsum_extract = sum(dsort(1:p));
end


%���岽������ǰp������ֵ����Ӧ�ĵ�����������ɵľ��󣬼��㽵ά�����������
vsort = vsort(:,1:p);%��ȡǰp�������������d*p����
fprintf(1,'Feature extraction and calculating newData...\n');
newdata=data*vsort;%����N��p�еľ��󣬴ﵽ��ά��Ч��