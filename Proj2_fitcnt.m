close all; clear; clc
%% Import Assets
T_train = readtable("train.csv");
train_data = table2cell(T_train);

T_test = readtable("test.csv");
test_data = table2cell(T_test);
%% Data Preparation
train_sex = grp2idx(train_data(:,2));
train_age_height_weight = cell2mat(train_data(:,3:5));
train_famHistory = grp2idx(train_data(:,6));
train_fchcf = grp2idx(train_data(:,7));
train_fcv_nmm = cell2mat(train_data(:,8:9));
train_cfbm = grp2idx(train_data(:,10));
train_smoke = grp2idx(train_data(:,11));
train_cw = cell2mat(train_data(:,12));
train_ccm = grp2idx(train_data(:,13));
train_paf_tut = cell2mat(train_data(:,14:15));
train_ca = grp2idx(train_data(:,16));
train_transportation = grp2idx(train_data(:,17));
train_obesity = normalize(grp2idx(train_data(:,18)));
 train_prep =([train_sex train_age_height_weight train_famHistory train_fchcf train_fcv_nmm train_cfbm train_smoke train_cw train_ccm train_paf_tut train_ca train_transportation]);


train_prep_confusion = [train_sex train_age_height_weight train_famHistory train_fchcf train_fcv_nmm train_cfbm train_smoke train_cw train_ccm train_paf_tut train_ca train_transportation];

test_sex = grp2idx(test_data(:,2));
test_age_height_weight = cell2mat(test_data(:,3:5));
test_famHistory = grp2idx(test_data(:,6));
test_fchcf = grp2idx(test_data(:,7));
test_fcv_nmm = cell2mat(test_data(:,8:9));
test_cfbm = grp2idx(test_data(:,10));
test_smoke = grp2idx(test_data(:,11));
test_cw = cell2mat(test_data(:,12));
test_ccm = grp2idx(test_data(:,13));
test_paf_tut = cell2mat(test_data(:,14:15));
test_ca = grp2idx(test_data(:,16));
test_transportation = grp2idx(test_data(:,17));
test_prep = normalize([test_sex test_age_height_weight test_famHistory test_fchcf test_fcv_nmm test_cfbm test_smoke test_cw test_ccm test_paf_tut test_ca test_transportation]);
%%
T_train = removevars(T_train,'ID');
T_train.Gender = categorical(T_train.Gender);
T_train.family_history = categorical(T_train.family_history);
T_train.FCHCF = categorical(T_train.FCHCF);
T_train.CFBM = categorical(T_train.CFBM);
T_train.Smoke = categorical(T_train.Smoke);
T_train.CCM = categorical(T_train.CCM);
T_train.CA = categorical(T_train.CA);
T_train.Transportation = categorical(T_train.Transportation);
T_train.Obesity = categorical(T_train.Obesity,["Insufficient_Weight","Normal_Weight","Overweight_Level_I","Overweight_Level_II","Obesity_Type_I","Obesity_Type_II","Obesity_Type_III"],"Ordinal",true);

%%
rng("default");
c = cvpartition(T_train.Obesity,"HoldOut",0.4);
trainingIndices = training(c);
testIndices = test(c);
obTrain = T_train(trainingIndices,:);
obTest = T_train(testIndices,:);

Mdl = fitcnet(T_train,"Obesity");

testAccuracy = 1 - loss(Mdl,obTest,"Obesity","LossFun","classiferror");
%%
mdl = fitcnet(train_prep,train_data(:,18));
id1 = predict(mdl,test_prep );
id1_confusion = predict(mdl,train_prep_confusion );

test_id = cell2mat(test_data(:,1));


test_id = num2cell(test_id);

 output = [test_id id1];
output = array2table(output,"VariableNames",["Id" "Obesity"]);
writetable(output,'train_test_with_BMI_with_weight_and_height_3_numPred_all.csv');
 plotconfusion(categorical(id1_confusion),categorical(train_data(:,18)));


%%
% valueCell={ 23,23,23, ...
%            9997,9997,9997,9997,9997,9997,9997, ...
%            11,11,11,11,11,11,11, ...
%            4,4,4,4,4, ...
%            60,60,60,60,60,60, ...
%            1010,1010,1010,1010,1010,1010,1010,1010, ...
%            3006,3006,3006,3006,3006, ...
%            80,80,80,80,80};
% 
% valueTable=cell2table(valueCell','VariableNames',{'value'});
% 
% conversionTable=table([    23,  9997,    11,     4,    60,  1010,  3006,    80]', ...
%                       {'BDHE','BEIS','CUAL','CTGB','MYMU','INJP','YNTA','TRQO'}', ...
%                       'VariableNames',{'value','str'});
% strTable=join(valueTable,conversionTable);