close all; clear ; clc;
load fisheriris
d = pdist(meas,'minkowski',2);
s= squareform(d);
Z = linkage(d,'ward');
[c,D] = cophenet(Z,d);
r = corr(d',D','type','spearman'); 
p = cluster(Z,'maxclust',3:6);
 H=dendrogram(Z);