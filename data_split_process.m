function [ dataL ,dataR ] = data_split_process( data , split_feat , split_value , feat_type )
%Split data according to catagorical/continious feature
%parameter:
%   data
%   split_feat : the number of the feature to split on
%   split_value : the value of the feature to split on
%   feat_type : the feature is catagorical(0), continious(1), or combined(2)
%       for linear combanition of featutes:
%           split_feat: the selected L features
%           split_value: the best combination value of L features
%           feat_type = [2, [coefficients w]]

switch feat_type(1)
    case 0
        dL = (data(:,split_feat) == split_value);
        dataL = data(dL,:);
        dataR = data(~dL,:);
        %dataL = data((data(:,split_feat) == split_value),:);
        %dataR = data((data(:,split_feat) ~= split_value),:);
        return
    case 1
        dL = (data(:,split_feat) > split_value);
        dataL = data(dL,:);
        dataR = data(~dL,:);

        %dataL = data((data(:,split_feat) > split_value),:);
        %dataR = data((data(:,split_feat) <= split_value),:);
        return
    case 2
        w = feat_type(2:size(feat_type,2));
        f = w * data(:,split_feat)';
        dL = (f' > split_value);
        dataL = data(dL,:);
        dataR = data(~dL,:);
        return
end

end

