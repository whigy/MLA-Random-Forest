function [ reg ] = calc_regvalue( data , T , cur_node , feature_type)
%calculate a regression value through a tree
if cur_node == 0
    cur_node = cur_node+1;
end

%format for T
%T(i,1:2) = child nodes
%T(i,3) = split feature
%(no use)T(i,4) = gini
%(no use)T(i,5) = leaf node/number of children
%(no use)T(i,6) = depth
%T(i,7) = regression value
%T(i,8) = split value

%feature_type : an aarray of feature type:
%   the feature is catagorical(0), continious(1), or combined(2)

if T(cur_node, 3)==0
    reg = T(cur_node, 7);
elseif feature_type(T(cur_node, 3)) == 0
    if data(T(cur_node, 3)) == T(cur_node, 8)
        reg = calc_regvalue( data , T , T(cur_node, 1) , feature_type);
    elseif data(T(cur_node, 3)) ~= T(cur_node, 8)
        reg = calc_regvalue( data , T , T(cur_node, 2) , feature_type);
    end
elseif feature_type(T(cur_node, 3)) == 1
    if data(T(cur_node, 3)) > T(cur_node, 8)
        reg = calc_regvalue( data , T , T(cur_node, 1) , feature_type);
    elseif data(T(cur_node, 3)) <= T(cur_node, 8)
        reg = calc_regvalue( data , T , T(cur_node, 2) , feature_type);
    end
end


