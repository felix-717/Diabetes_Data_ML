close all; clear; clc

%https://www.mathworks.com/matlabcentral/answers/399062-how-to-set-tree-arguments-in-treebagger
%https://www.mathworks.com/help/stats/treebagger.html
%https://www.mathworks.com/help/stats/treebagger.predict.html
%https://www.mathworks.com/matlabcentral/answers/522060-what-is-the-difference-form-using-treebagger-and-fitrensemble-functions

%% Loading the Data and storing them in a Table

[~,~,rawtrain] = xlsread('train.csv');
[~,~,rawtest] = xlsread('test.csv');

train = cell2table(rawtrain(2:end,:),'VariableNames',rawtrain(1,:));
test = cell2table(rawtest(2:end,:),'VariableNames',rawtest(1,:));

%% Accessing Feature elements of the Table
%features
train.Gender = categorical(train.Gender);
train.family_history = categorical(train.family_history);
train.FCHCF= categorical(train.FCHCF);
train.CFBM= categorical(train.CFBM);
train.Smoke= categorical(train.Smoke);
train.CA= categorical(train.CA);
train.CCM= categorical(train.CCM);
train.Transportation= categorical(train.Transportation);

%output
train.Obesity= categorical(train.Obesity);


test.Gender = categorical(test.Gender);
test.family_history = categorical(test.family_history);
test.FCHCF= categorical(test.FCHCF);
test.CFBM= categorical(test.CFBM);
test.Smoke= categorical(test.Smoke);
test.CA= categorical(test.CA);
test.CCM= categorical(test.CCM);
test.Transportation= categorical(test.Transportation);


%% Sample data cleaning
%fill missing values



%% Training the Model
%change features na lang
% train_data = [train.Weight, train.family_history, train.FCHCF, train.NMM, train.CFBM, train.Smoke, train.CCM, train.PAF, train.TUT, train.CA, train.Transportation];
% test_data = [test.Weight, test.family_history, test.FCHCF, test.NMM, test.CFBM, test.Smoke, test.CCM, test.PAF, test.TUT, test.CA, test.Transportation];

train_data = train(:, 2:17);
test_data = test(:, 2:17);


maxNumSplits = 10; %max number of decision splits
minLeafSize = 1; %min number of leaf node observations
minParentSize = 3; %min number of branches (not supported)
numberPredictorsToSample = width(train_data); %number of random feature for each decision, default = squareroot of the total number of features

numTrees = 1000; %Scalar value equal to the number of desicion trees
method = 'classification';

%max depth parameter not supported in treebagger object
RF = TreeBagger(numTrees,train_data,train.Obesity,...    
    'Method',method,...        %you have to say whether it is a regression or classification problem
    'MaxNumSplits',maxNumSplits,...
    'MinLeafSize',minLeafSize,...
    'NumPredictorsToSample','all');



%% Sample Data Output


Obesity = predict(RF, test_data);
ID = test.ID;



%Preparing the Kaggle Submission
T=table(ID, Obesity);
writetable(T,'proj2_my_submission_attempt_2.csv');
fprintf("Done");
% 
% %% function definitions
% function print()
%     fprintf("hello")
% end
