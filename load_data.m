load('regressionData.mat')
ozone = importdata('ozone.txt');
ozone_data = ozone.data(:,2:end);
ozone_data = ozone_data(:,[1:(end-1),1]);

init_data_name = 'ozone';
%define feature type: 0=catagorical; 1=continious
if strcmp(init_data_name, 'bostonhousing')
    init_data = bostonhousing;
    feature_type = ones(1,13);
    feature_type(4) = 0;
elseif strcmp(init_data_name, 'abalone')
    init_data = abalone(:,[9,1:8]);
    feature_type = ones(1,8);
    feature_type(1) = 0;
elseif strcmp(init_data_name, 'servo')
    init_data = servo;
    feature_type = zeros(1,4);
elseif strcmp(init_data_name, 'ozone')
    init_data = ozone_data;
    feature_type = ones(1,8);
end