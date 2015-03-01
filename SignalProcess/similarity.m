


function [s] = Similarity(A,B)
    s = dot(A,B)/(norm(A)*norm(B));