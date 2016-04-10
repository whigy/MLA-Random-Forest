function [ reg ] = calc_regRCvalue( data , T , cur_node, L)
%calculate a regression value through a tree
if cur_node == 0
    cur_node = cur_node+1;
end

%format for T
%T(i,1:2) = child nodes
%(no use)T(i,4) = gini
%T(i,5) = leaf node/number of children
%(no use)T(i,6) = depth
%T(i,7) = regression value
%T(i,8) = split value
%T(i,9:8+L) = split features
%T(i,9+L:8+2L) = coefficients w

%feature_type : an aarray of feature type:
%   the feature is catagorical(0), continious(1), or combined(2)


if T(cur_node, 5)==0
    reg = T(cur_node, 7);
else
    w = T(cur_node,(9+L):(8+2*L));
    f = data(1,T(cur_node, 9:(8+L)));
    if (w*f') > T(cur_node, 8)
        reg = calc_regRCvalue( data , T , T(cur_node, 1), L);
    elseif (w*f') <= T(cur_node, 8)
        reg = calc_regRCvalue( data , T , T(cur_node, 2), L);
    end
end


