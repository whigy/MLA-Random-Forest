function [ F ] = reg_RF_RI( data , times , feat_select, feature_type)
%this function produce a random forest
%parameter:
%   data
%   times = the number of trees in the forest
%   feat_select:different methods to select feature (RI)
%      0 ; RF don't select feature
%      1 : RF with selecting F=1 feature
%      2 : RF with selecting F=log2(M)+1 features
%   feature_type : an array of feature type:
%       the feature is catagorical(0), continious(1), or combined(2)

F = cell(1,times);
sample_data = bootstrap(times, data);

for k = 1:times
    T = build_regtree(sample_data(:,:,k) , 0 , feat_select, feature_type);
    F{k} = T;
end

