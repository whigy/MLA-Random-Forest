function [ feat ] = feature_select( data , feat_sel)

%feature selection:
%   0 : keep all features
%   1 : F = 1
%   2 : F = log2(M) + 1
%   3 : Linear combination features; format :[3, L ,F]
%return the number of selected features

[n, targetCol] = size(data);
M = targetCol-1;
switch feat_sel(1)
    case 0
        feat = [1:M];
        return
    case 1
        feat = floor(rand()*M)+1;
        return
    case 2
        a = 1:M;
        K = randperm(length(a));
        N = floor(log2(M)+1);
        feat = sort(a(K(1:N)));
        return
    case 3
        L = feat_sel(2);
        F = feat_sel(3);
        feat = [];
        a = 1:M;
        for i = 1:F
            K = randperm(length(a));
            feat = [feat; sort(a(K(1:L)))];
        end
        return
end

