load_data

l = 2;
f = 25;

%randomize data
[n,m] = size(init_data);

%pre-process the data for RC
[data , new_feature_type]  = rc_data_preprocess( init_data, feature_type );   

b_a = [];
t_a = [];
o_a = [];
o_b = [];
times = 100; 
for i = 1:10
   %oob estimation for forest
   oob_err_reg = oob_reg_err( data , times, new_feature_type, l , f);
   o_a = [o_a,oob_err_reg];
   %oob estmation for bagging
   oob_err_bag = oob_regbagging_err( init_data , times ,0, feature_type);
   o_b = [o_b,oob_err_bag];
   i
end

times = 100
for i = 1:10
    %random data
    p = randperm(n);
    train = data(p(1:floor(n*0.9)), :);
    test = data(p(floor(n*0.9)+1:n), :);
    train_bagging = init_data(p(1:floor(n*0.9)), :);
    test_bagging = init_data(p(floor(n*0.9)+1:n), :);
    
    %test Forest
    F = reg_RF_RC( train , times, new_feature_type, l , f);
    reg = calc_regRCvalue_RF( test , F , l);
    a = [reg, test(:, size(test,2))];
    test_error = mean((a(:,1)-a(:,2)).^2);
    t_a = [t_a,test_error];
    
    %test bagging
    feat_select = 0;
    B = reg_RF_RI( train_bagging , times ,feat_select, feature_type);
    reg_b = calc_regvalue_RF( test_bagging , B , feature_type);
    a_b = [reg_b, test_bagging(:, size(test_bagging,2))];
    bagging_error = mean((a_b(:,1)-a_b(:,2)).^2);
    b_a = [b_a,bagging_error];
    i
end

mean(o_a)
mean(o_b)
mena(t_a)
mena(b_a)
