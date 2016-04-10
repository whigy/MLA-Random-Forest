function [ regRF ] = calc_regRCvalue_RF( data , F , l)
% return the regression values averaged from a forest
[x , f] = size(F);
[data_size, targetCol] = size(data);
regVal = zeros(data_size,f);
regRF = zeros(data_size,1);
for j = 1:f
    for i = 1:data_size
        regVal(i,j) = calc_regRCvalue(data(i,:), F{j}, 0, l);
    end
end
for i = 1:data_size
    regRF(i,1) = mean(regVal(i,:));
end
    


