function [ F ] = reg_RF_RC( data , times , feature_type , l , f)
%this function produce a random forest
%parameter:
%   data
%   times = the number of trees in the forest
%   feature_type : an array of feature type:
%       the feature is catagorical(0), continious(1)

F = cell(1,times);
sample_data = bootstrap(times, data);

for k = 1:times
    T = build_regRCtree(sample_data(:,:,k), 0 , feature_type , l , f);
    F{k} = T;
end

