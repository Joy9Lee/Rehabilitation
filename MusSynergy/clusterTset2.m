close all; clear ; clc;
X=randn(200,7);
plot(X(:,1),X(:,2),'bo')
 Y=pdist(X);
s= squareform(Y);
Z=linkage(Y)
dendrogram(Z)