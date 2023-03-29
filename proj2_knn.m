close all; clear; clc

%https://www.mathworks.com/matlabcentral/answers/399062-how-to-set-tree-arguments-in-treebagger
%https://www.mathworks.com/help/stats/treebagger.html
%https://www.mathworks.com/help/stats/treebagger.predict.html
%https://www.mathworks.com/matlabcentral/answers/522060-what-is-the-difference-form-using-treebagger-and-fitrensemble-functions
%https://www.mathworks.com/help/stats/treebagger.html

%% Loading the Data and storing them in a Table

[~,~,rawtrain] = xlsread('train.csv');
[~,~,rawtest] = xlsread('test.csv');

train = cell2table(rawtrain(2:end,:),'VariableNames',rawtrain(1,:));
test = cell2table(rawtest(2:end,:),'VariableNames',rawtest(1,:));
%% Accessing Feature elements of the Table

%features
% train.Gender = categorical(train.Gender);
% train.family_history = categorical(train.family_history);
% train.FCHCF= categorical(train.FCHCF);
% train.CFBM= categorical(train.CFBM);
% train.Smoke= categorical(train.Smoke);
% train.CA= categorical(train.CA);
% train.CCM= categorical(train.CCM);
% train.Transportation= categorical(train.Transportation);
train_age = cell2mat(rawtrain(2:1478,3 ));
train_height = cell2mat(rawtrain(2:1478,4));
train_weight = cell2mat(rawtrain(2:1478,5));
% train_obesity = cell2mat(train.Obesity);



%reassign
% obesity_words = cell(634,1);
% for i = 1:634 
%     if(id(i) ==1)
%         obesity_words(i) = {'Obesity_Type_III'};
%      elseif(id(i) ==2)
%          obesity_words(i) = {'Obesity_Type_II'};
%      elseif(id(i) ==3)
%          obesity_words(i) = {'Obesity_Type_I'};
%      elseif(id(i) ==4)
%         obesity_words(i) = {'Overweight_Level_II'};
%      elseif(id(i) ==5)
%          obesity_words(i) = {'Overweight_Level_I'};
%      elseif(id(i) ==6)
%          obesity_words(i) = {'Normal_Weight'};
%     elseif(id(i) ==7)
%          obesity_words(i) = {'Insufficent_Weight'};     
%     end    
% end

train_bmi = train_height ./ (train_height.^2);

x = [train_age train_height train_weight train_bmi];

%train model
mdl = fitcknn(x,train.Obesity,'NumNeighbors',1);

% train_Gender = grp2idx(train(:,2));
% train.family_history = categorical(train.family_history);
% train.FCHCF= categorical(train.FCHCF);
% train.CFBM= categorical(train.CFBM);
% train.Smoke= categorical(train.Smoke);
% train.CA= categorical(train.CA);
% train.CCM= categorical(train.CCM);
% train.Transportation= categorical(train.Transportation);


% %add a new entry
% train.BMI = train.Weight ./ train.Height.^2;
% 
% 
% %output
% train.Obesity= categorical(train.Obesity);
% 
% 
% test.Gender = categorical(test.Gender);
% test.family_history = categorical(test.family_history);
% test.FCHCF= categorical(test.FCHCF);
% test.CFBM= categorical(test.CFBM);
% test.Smoke= categorical(test.Smoke);
% test.CA= categorical(test.CA);
% test.CCM= categorical(test.CCM);
% test.Transportation= categorical(test.Transportation);
% 
% %add a new entry
% test.BMI = test.Weight ./ test.Height.^2;





test_age = cell2mat(rawtest(2:635,3 ));
test_height = cell2mat(rawtest(2:635,4));
test_weight = cell2mat(rawtest(2:635,5));

test_bmi = test_height ./ (test_height.^2);


x_test = [test_age test_height test_weight test_bmi];
x_train = [train_age train_height train_weight train_bmi];
id1 = predict(mdl,x_test );
id1_confusion = predict(mdl,x_train );


 test_id = cell2mat(rawtest(2:635,1 ));
% 
% 
% test_prep = normalize([test_age  test_height test_weight test_bmi]);
% 
% id = kmeans(test_prep, 7);
% 
% 
% 
% 
% 
% 
test_id = num2cell(test_id);

 output = [test_id id1];
output = array2table(output,"VariableNames",["Id" "Obesity"]);
writetable(output,'train_test_with_BMI_with_weight_and_height_3_numPred_all.csv');
 plotconfusion(categorical(id1_confusion),categorical(train.Obesity));

%make obesity 
