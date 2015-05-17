close all
clear
clc

%% Load and normalize training set
ims_train = load('pedestrian_training.mat');
ims = ims_train.ims;
ys_train = ims_train.y;

Xtrain = ComputeHog(ims);

% Normalize data
n = size(ims, 2);
d = 9*5*31;
mu = mean(Xtrain, 2);
sigma = std(Xtrain, 0, 2);
Xtrain = (Xtrain - repmat(mu, 1, n)) ./ repmat(sigma, 1, n);


%% Find best lambda

T = 40;
ims_val = load('pedestrian_validation.mat');
ims = ims_val.ims;
ys_val = ims_val.y;
nval = size(ims, 2);
Xval = ComputeHog(ims);
Xval = (Xval - repmat(mu, 1, nval)) ./ repmat(sigma, 1, nval);

% Find the best lambda
lambdas = [0.01, 0.001, 0.0001, 0.00001];
nl = length(lambdas);
acc = zeros(nl, 1);
for i = 1:nl
    fprintf('\nlambda = %f\n', lambdas(i));
    [w, b] = TrainSVM(Xtrain, ys_train, lambdas(i), T);
    acc(i) = ComputeAccuracy(w, b, Xval, ys_val);
    fprintf('Accuracy on validation set: %3.1f%%\n', acc(i)*100);
end
[~, i_min] = min(acc);
lambda = lambdas(i_min);
fprintf('\nBest lambda: %f\nCalculating ultimate SVM...\n', lambda);

% Train ultimate SVM
Xtv = [Xtrain, Xval];
ys_tv = [ys_train; ys_val];
ntv = size(Xtv, 2);
[w, b] = TrainSVM(Xtv, ys_tv, lambda, T);


%% Accuracy on test set

fprintf('\nCalculating accuracy on test set...\n')
data_test = load('pedestrian_test.mat');
ims_test = data_test.ims;
ys_test = data_test.y;

% Convert to single and compute hog descriptor
Xtest = ComputeHog(ims_test);

% Normalize with same parameters as for training data
n = size(Xtest, 2);
Xtest = (Xtest - repmat(mu, 1, n)) ./ repmat(sigma, 1, n);

% Classify and compute accuracy
acc = ComputeAccuracy(w, b, Xtest, ys_test);

fprintf('Accuracy on test set: %3.1f%%\n', acc*100);