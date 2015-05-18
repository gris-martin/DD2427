close all
clear
clc

%% Load strong classifier parameters
TData = load('training_data.mat');
% dinfo7 = load('DebugInfo/debuginfo7.mat');
% T = dinfo7.T;
% Cparams = BoostingAlg(TData, T);
Cparams = load('classifier_parameters.mat');
%% Apply detector
[~, ii_im] = LoadImage('TrainingImages/FACES/face00001.bmp');
scs = ApplyDetector(Cparams, ii_im(:))

%% ROC curve
figure;
ComputeROC(Cparams, TData)
Cparams.thresh = 1.75;

save('classifier_parameters', '-struct', 'Cparams')