function  [data , new_feature_type]  = rc_data_preprocess( init_data, feature_type )
data = [];
new_feature_type = [];
for i = 1:size(feature_type,2)
    if feature_type(i) == 0
        s = unique(init_data(:,i));
        sub = [];
        for j = 1:size(s, 1)-1
            sub = [sub, [init_data(:,i) == s(j)]];
        end
        data = [data, sub(:,:)];
        new_feature_type = [new_feature_type, zeros(1,(size(s, 1)-1))];
    else data = [data, init_data(:,i)];
        new_feature_type = [new_feature_type, 1];
    end
end
data = [data, init_data(:,size(init_data,2))];
end

