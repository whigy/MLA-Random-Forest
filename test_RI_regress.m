load('C:\Users\Huijie\Documents\MATLAB\ranforest\data.mat')
%data should be changed into regression data
%not sure whether there are bugs, contact me if there's any problem
%the format of the tree will be adjusted according to classification tree

data = bostonhousing;
%define feature type: 0=catagorical; 1=continious
if data == bostonhousing
    feature_type = ones(1,13);
    feature_type(4) = 0;
elseif data == abalone
    data = abalone(:,[9,1:8]);
    feature_type = ones(1,8);
    feature_type(1) = 0;
elseif data == servo
    feature_type = zeros(1,4);
end
    
[n,m] = size(data);
p = randperm(n);
train = data(p(1:floor(n*0.9)), :);
test = data(p(floor(n*0.9)+1:n), :);

%build one tree
T = build_regtree(train, 0 , 0, feature_type);
err = calc_regerror(T, test , feature_type);

%build a forest
times = 20; %sample 100 times
feat_select = 2;
F = reg_RF_RI( train , times ,feat_select, feature_type);
reg = calc_regvalue_RF( test , F , feature_type);

%out of bag estimation




%build a RC-tree
T = build_regRCtree(train, 0 , feature_type , 3, 2);
%err = calc_regerror(T, test , feature_type);