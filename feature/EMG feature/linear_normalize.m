function N = linear_normalize(D)
% Linear Normalization

    max_value = max(D);
    min_value =min(D);

    N = (D-min_value) / (max_value-min_value);
end
