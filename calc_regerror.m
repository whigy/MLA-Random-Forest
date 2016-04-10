function [ err ] = calc_regerror( T, data, feature_type )

[data_size, targetCol] = size(data);
%features = targetCol-1;
regVal = zeros(1,data_size);
for i = 1:data_size
    regVal(i) = calc_regvalue(data(i,:), T, 0, feature_type);
end
%[regm, regn] = size(regVal);
err = mean((data(:,targetCol)'-regVal).^2);



