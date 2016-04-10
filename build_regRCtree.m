function T = build_regRCtree( data , cur_depth, feature_type , L, F)
%recursively builds regression tree using CART
%following Harrington, Peter. Machine learning in action. Manning, 2012.

T = zeros(1,(8+2*L));
%format for T
%T(i,1:2) = child nodes
%T(i,4) = gini
%T(i,5) = leaf node/number of children
%T(i,6) = depth
%T(i,7) = regression value
%T(i,8) = split value
%T(i,9:8+L) = split features
%T(i,9+L:8+2L) = coefficients w

[n, targetCol] = size(data);
M = targetCol-1;

%reshape data according to feature selection:
feature = feature_select( data , [3, L ,F]);

w = rand( F, L )*2-1;
% form temp_data
temp_data = [];
for i = 1:F
    temp_d = data(:,feature(i,:));
    f = w(i,:) * temp_d';
    temp_data = [temp_data, f'];
end
temp_data = [temp_data, data(:, targetCol)];
temp_feature = 1:F;
temp_feature_type = ones(1, F);

[ temp_split_feat, split_value, gini ] = reg_split( temp_data ,cur_depth , temp_feature, 0.1 , 5 , temp_feature_type);

if temp_split_feat == -1
    T(7) = split_value;
    return;
end

%identify the gini impurity
T(4) = gini;
%identify number of child nodes
T(5) = 2;
%label depth
T(6) = cur_depth;
%identify the split value F
T(8) = split_value;
%identify the split features
split_feat = feature(temp_split_feat,:);
T(9:(8+L)) = split_feat(1,:);
%save coefficient w
T((9+L):(8+2*L)) = w(temp_split_feat,:);

%call build tree recursively for child nodes
%[ dataL ,dataR ] = data_split_process( data , split_feat , split_value , [2, w(temp_split_feat,:)]);
%function [ dataL ,dataR ] = data_split_process( data , split_feat , split_value , feat_type )
f = w(temp_split_feat,:) * data(:,split_feat)';
dL = (f' > split_value);
%dataL = data(dL,:);
%dataR = data(~dL,:);

[sub_TL] = build_regRCtree(data(dL,:), cur_depth+1, feature_type , L, F);
[sub_TR] = build_regRCtree(data(~dL,:), cur_depth+1, feature_type , L, F);
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

