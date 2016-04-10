function [ regRF ] = calc_regvalue_RF( data , F , feature_type)
% return the regression values averaged from a forest
[x , f] = size(F);
[data_size, targetCol] = size(data);
regVal = zeros(data_size,f);
regRF = zeros(data_size,1);
for j = 1:f
    for i = 1:data_size
        regVal(i,j) = calc_regvalue(data(i,:), F{j}, 0, feature_type);
    end
end
for i = 1:data_size
    regRF(i,1) = mean(regVal(i,:));
end
    


