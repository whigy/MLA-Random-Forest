function [ bestIndex, bestValue, giniValue ] = reg_split( data, cur_depth, feature, max_error, min_example , feature_type)
%reg_split
%parameter:
%   data: features + prediction target
%   cur_depth : current depth of the tree
%   feature : an array of available features (for feature selection)
%   max_error, min_example: stop recursive requirements, usually use 0.5&5
%   feature_type : an array of feature type:
%       the feature is catagorical(0), continious(1)

[n_examples,targetCol] = size(data);
features = targetCol - 1;


if cur_depth ==100 || size(data(:,targetCol),1) < min_example
     bestIndex = -1;
     bestValue = mean(data(:,targetCol)) ;
     giniValue = -1;
     return;
end

gini = sum((data(:,targetCol)-(sum(data(:,targetCol))/n_examples)).^2);%var(data(:,targetCol)) * n_examples;
best_gini = Inf;
best_feat = 0;
best_split = 0;
for feat_i = feature
    %split_val = unique(data(:,feat_i));
    %%optimize unique function
    %% INLINED unique() (assumes order=='sorted')
    a = data(:, feat_i);
    numelA = numel(a);
    sortA = sort(a);
    
    % groupsSortA indicates the location of non-matching entries.
    if numelA > 1 %if isnumeric(sortA) && (numelA > 1)
        dSortA = diff(sortA);
        if (isnan(dSortA(1)) || isnan(dSortA(numelA-1)))
            unique_indices(2:numelA) = sortA(1:numelA-1) ~= sortA(2:numelA);
        else
            unique_indices(2:numelA) = dSortA ~= 0;
        end 
    else
        unique_indices(2:numelA) = sortA(1:numelA-1) ~= sortA(2:numelA);
    end
    
    unique_indices(1) = true;               % First element is always a member of unique list.
    split_val = sortA(unique_indices);         % Create unique list by indexing into sorted list.
    %%
    
    for i = 1:size(split_val,1)
        %split data according to feature (for regression, the features
        %are continuious and the size is large, how to fix???
        [ dataL ,dataR ] = data_split_process( data , feat_i , split_val(i) , feature_type(feat_i));
        if size(dataL,1) < 1 || size(dataR,1) < 1
            continue;
        end
        %dataL = data(dL,:);
        %dataR = data(dR,:);
        gini_sub = sum((dataL(:,targetCol)-(sum(dataL(:,targetCol))/size(dataL,1))).^2)+sum((dataR(:,targetCol)-(sum(dataR(:,targetCol))/size(dataR,1))).^2);%var(dataL(:,targetCol)) * size(dataL,1) + var(dataR(:,targetCol)) * size(dataR,1);
        if gini_sub < best_gini
            best_gini = gini_sub;
            best_feat = feat_i;
            best_split = split_val(i);
        end
    end
    if best_feat == 0
        bestIndex = -1;
        bestValue = mean(data(:,targetCol));
        giniValue = -1;
        return;
    end
end

if abs(gini-best_gini) < max_error
    %Exit if gini impurity changes little
    bestIndex = -1;
    bestValue = mean(data(:,targetCol));
    giniValue = -1;
    return;
end

%[ dataL ,dataR ] = data_split_process( data , best_feat , best_split , feature_type(best_feat));
%function [ dataL ,dataR ] = data_split_process( data , split_feat , split_value , feat_type )
%dataL = data(dL,:);
%dataR = data(dR,:);

%if size(dataL,1) < 1 || size(dataR,1) < 1
%     bestIndex = -1;
%     bestValue = mean(data(:,targetCol));
%     giniValue = -1;
%     return;
% end

%Exit and return new split method
bestIndex = best_feat;
bestValue = best_split;
giniValue = best_gini;
end


