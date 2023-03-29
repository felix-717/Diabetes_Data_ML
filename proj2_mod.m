close all; clear; clc

%https://www.mathworks.com/matlabcentral/answers/399062-how-to-set-tree-arguments-in-treebagger
%https://www.mathworks.com/help/stats/treebagger.html
%https://www.mathworks.com/help/stats/treebagger.predict.html
%https://www.mathworks.com/matlabcentral/answers/522060-what-is-the-difference-form-using-treebagger-and-fitrensemble-functions

%% Loading the Data and storing them in a Table

[~,~,rawtrain] = xlsread('train.csv');
[~,~,rawtest] = xlsread('test.csv');

trainx = cell2table(rawtrain(2:end,:),'VariableNames',rawtrain(1,:));
test = cell2table(rawtest(2:end,:),'VariableNames',rawtest(1,:));



%% Accessing Feature elements of the Table
%features
% replace categorical to numerical 

%gender 
trainx.Gender  = replace(trainx.Gender, "Female", "1");
trainx.Gender = replace(trainx.Gender, "Male", "0");
trainx.Gender = cellfun(@str2num, trainx.Gender, 'UniformOutput', false);

%family_history
trainx.family_history  = replace(trainx.family_history, "yes", "1");
trainx.family_history = replace(trainx.family_history, "no", "0");
trainx.family_history = cellfun(@str2num, trainx.family_history, 'UniformOutput', false);

%family_history
trainx.FCHCF  = replace(trainx.FCHCF, "yes", "1");
trainx.FCHCF = replace(trainx.FCHCF, "no", "0");
trainx.FCHCF = cellfun(@str2num, trainx.FCHCF, 'UniformOutput', false);

%Consuption b4 meals 
trainx.CFBM  = replace(trainx.CFBM, "no", "1");
trainx.CFBM = replace(trainx.CFBM, "Sometimes", "2");
trainx.CFBM  = replace(trainx.CFBM, "Frequently", "3");
trainx.CFBM = replace(trainx.CFBM, "Always", "4");
trainx.CFBM = cellfun(@str2num, trainx.CFBM, 'UniformOutput', false);

%smoke
trainx.Smoke  = replace(trainx.Smoke, "yes", "1");
trainx.Smoke = replace(trainx.Smoke, "no", "0");
trainx.Smoke = cellfun(@str2num, trainx.Smoke, 'UniformOutput', false);

%ccm
trainx.CCM  = replace(trainx.CCM, "yes", "1");
trainx.CCM = replace(trainx.CCM, "no", "0");
trainx.CCM = cellfun(@str2num, trainx.CCM, 'UniformOutput', false);

%ca
trainx.CA  = replace(trainx.CA, "no", "1");
trainx.CA = replace(trainx.CA, "Sometimes", "2");
trainx.CA  = replace(trainx.CA, "Frequently", "3");
trainx.CA = replace(trainx.CA, "Always", "4");
trainx.CA = cellfun(@str2num, trainx.CA, 'UniformOutput', false);


%transportation
trainx.Transportation  = replace(trainx.Transportation, "Automobile", "1");
trainx.Transportation = replace(trainx.Transportation, "Motorbike", "2");
trainx.Transportation  = replace(trainx.Transportation, "Bike", "3");
trainx.Transportation = replace(trainx.Transportation, "Public_Transportation", "4");
trainx.Transportation = replace(trainx.Transportation, "Walking", "5");
trainx.Transportation = cellfun(@str2num, trainx.Transportation, 'UniformOutput', false);


%obesity
trainx.Obesity = replace(trainx.Obesity, "Obesity_Type_III", "7");
trainx.Obesity = replace(trainx.Obesity, "Obesity_Type_II", "6");
trainx.Obesity = replace(trainx.Obesity, "Obesity_Type_I", "5");


trainx.Obesity  = replace(trainx.Obesity, "Insufficient_Weight", "1");
trainx.Obesity = replace(trainx.Obesity, "Normal_Weight", "2");
trainx.Obesity = replace(trainx.Obesity, "Overweight_Level_II", "4");
trainx.Obesity  = replace(trainx.Obesity, "Overweight_Level_I", "3");


trainx.Obesity = cellfun(@str2num, trainx.Obesity, 'UniformOutput', false);


%numerical test values 

%gender 
test.Gender  = replace(test.Gender, "Female", "1");
test.Gender = replace(test.Gender, "Male", "0");
test.Gender = cellfun(@str2num, test.Gender, 'UniformOutput', false);

%family_history
test.family_history  = replace(test.family_history, "yes", "1");
test.family_history = replace(test.family_history, "no", "0");
test.family_history = cellfun(@str2num, test.family_history, 'UniformOutput', false);

%family_history
test.FCHCF  = replace(test.FCHCF, "yes", "1");
test.FCHCF = replace(test.FCHCF, "no", "0");
test.FCHCF = cellfun(@str2num, test.FCHCF, 'UniformOutput', false);

%Consuption b4 meals 
test.CFBM  = replace(test.CFBM, "no", "1");
test.CFBM = replace(test.CFBM, "Sometimes", "2");
test.CFBM  = replace(test.CFBM, "Frequently", "3");
test.CFBM = replace(test.CFBM, "Always", "4");
test.CFBM = cellfun(@str2num, test.CFBM, 'UniformOutput', false);

%smoke
test.Smoke  = replace(test.Smoke, "yes", "1");
test.Smoke = replace(test.Smoke, "no", "0");
test.Smoke = cellfun(@str2num, test.Smoke, 'UniformOutput', false);

%ccm
test.CCM  = replace(test.CCM, "yes", "1");
test.CCM = replace(test.CCM, "no", "0");
test.CCM = cellfun(@str2num, test.CCM, 'UniformOutput', false);

%ca
test.CA  = replace(test.CA, "no", "1");
test.CA = replace(test.CA, "Sometimes", "2");
test.CA  = replace(test.CA, "Frequently", "3");
test.CA = replace(test.CA, "Always", "4");
test.CA = cellfun(@str2num, test.CA, 'UniformOutput', false);


%transportation
test.Transportation  = replace(test.Transportation, "Automobile", "1");
test.Transportation = replace(test.Transportation, "Motorbike", "2");
test.Transportation  = replace(test.Transportation, "Bike", "3");
test.Transportation = replace(test.Transportation, "Public_Transportation", "4");
test.Transportation = replace(test.Transportation, "Walking", "5");
test.Transportation = cellfun(@str2num, test.Transportation, 'UniformOutput', false);




%output
% trainx.Obesity= categorical(trainx.Obesity);
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


%% Sample data cleaning
%fill missing values



%% Training the Model


%fitcnet 
trainx = removevars(trainx,"ID");

test = removevars(test,"ID");

Mdl = fitcnet(trainx, "Obesity")


%change features na lang
% train_data = [train.Weight, train.family_history, train.FCHCF, train.NMM, train.CFBM, train.Smoke, train.CCM, train.PAF, train.TUT, train.CA, train.Transportation];
% test_data = [test.Weight, test.family_history, test.FCHCF, test.NMM, test.CFBM, test.Smoke, test.CCM, test.PAF, test.TUT, test.CA, test.Transportation];


% 
% input  = rows2vars(trainx(:, 2:17)); % input 
% test_data = test(:, 2:17);
% target = trainx.Obesity';
% 
% 
% maxNumSplits = 10; %max number of decision splits
% minLeafSize = 1; %min number of leaf node observations
% minParentSize = 3; %min number of branches (not supported)
% numberPredictorsToSample = width(train_data); %number of random feature for each decision, default = squareroot of the total number of features
% 
% numTrees = 1000; %Scalar value equal to the number of desicion trees
% method = 'classification';
% 
% %max depth parameter not supported in treebagger object
% RF = TreeBagger(numTrees,train_data,train.Obesity,...    
%     'Method',method,...        %you have to say whether it is a regression or classification problem
%     'MaxNumSplits',maxNumSplits,...
%     'MinLeafSize',minLeafSize,...
%     'NumPredictorsToSample','all');
% 

%%create cnn

% net = fitcnet(input, target );
% net.input.processFcns = {'removeconstantrows','mapminmax'};
% net.output.processFcns = {'removeconstantrows','mapminmax'};
% net.divideFcn = 'dividerand';
% net.divideMode = 'sample';
% net.divideParam.trainRatio = 80/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 5/100;
% net.performFcn = 'mse';
% net.trainParam.epochs = 150;
% net.trainParam.max_fail = 100;
% net.trainParam.min_grad = 1e-09;
% net = train (net, input,target);
% 

% 
% trainnetwork = net;
% save trainnetwork

% %% Sample Data Output
% 
% 
% Obesity = predict(RF, test_data);
% ID = test.ID;
% 
% 
% 
% %Preparing the Kaggle Submission
% T=table(ID, Obesity);
% writetable(T,'proj2_my_submission_attempt_2.csv');
% fprintf("Done");
% % 
% % %% function definitions
% % function print()
% %     fprintf("hello")
% % end
