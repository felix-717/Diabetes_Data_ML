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

trainx = removevars(trainx,"ID");

test = removevars(test,"ID");

trainx.Gender = categorical(trainx.Gender, ...
    ["Male","Female"],"Ordinal",true);

Mdl = fitcnet(trainx, "Gender")

testAccuracy = 1 - loss(Mdl,trainx,"Gender", ...
    "LossFun","classiferror")


confusionchart(creditTest.Rating,predict(Mdl,creditTest))