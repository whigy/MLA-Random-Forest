function T = build_regtree( data , cur_depth , feat_select , feature_type)
%recursively builds regression tree using CART
%following Harrington, Peter. Machine learning in action. Manning, 2012.

T = zeros(1,8);
%format for T
%T(i,1:2) = child nodes
%T(i,3) = split feature
%T(i,4) = gini
%T(i,5) = leaf node/number of children
%T(i,6) = depth
%T(i,7) = regression value
%T(i,8) = split value

%reshape data according to feature selection:
feature = feature_select( data , feat_select);
[ split_feat, split_value, gini ] = reg_split( data ,cur_depth , feature, 0.1 , 5 , feature_type);

if split_feat == -1
    T(7) = split_value;
    return;
end


%identify the splitting attribute
T(3) = split_feat;
%identify the gini impurity
T(4) = gini;
%identify number of child nodes
T(5) = 2;
%label depth
T(6) = cur_depth;
%identify the split value
T(8) = split_value;

%call build tree recursively for child nodes
[ dataL ,dataR ] = data_split_process( data , split_feat , split_value , feature_type(split_feat));
%dataL = data(dL,:);
%dataR = data(dR,:);
[sub_TL] = build_regtree(dataL, cur_depth+1, feat_select, feature_type);
[sub_TR] = build_regtree(dataR, cur_depth+1, feat_select, feature_type);
[max_node,xx] = size(T);  
T = [T;sub_TL];  
T(1,1) = max_node+1;
[max_node,xx] = size(T);
T = [T;sub_TR];  
T(1,2) = max_node+1;

%adjust the node number of child trees
if (cur_depth == 0)
  [m , n] = size(T);
  for i = 1:m
    T(i,1:2) = T(i,1:2) + (T(i,1:2) > 0) * (i-1);
  end
end

