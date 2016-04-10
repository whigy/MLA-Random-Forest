function [ err ] = calc_regRCerror( T, data, L )

[data_size, targetCol] = size(data);
%features = targetCol-1;
regVal = zeros(1,data_size);
for i = 1:data_size
    regVal(i) = calc_regRCvalue(data(i,:), T, 0, L);
end
%[regm, regn] = size(regVal);
err = mean((data(:,targetCol)'-regVal).^2);



