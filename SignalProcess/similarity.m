


function [s] = similarity(A,B)
    s = dot(A,B)/(norm(A)*norm(B));