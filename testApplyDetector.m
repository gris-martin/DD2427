close all
clear
clc


% Test the detector
%% Load strong classifier parameters
TData = load('training_data.mat');
dinfo7 = load('DebugInfo/debuginfo7.mat');
T = dinfo7.T;
Cparams = BoostingAlg(TData, T);

%% Apply detector
[~, ii_im] = LoadImage('TrainingImages/FACES/face00001.bmp');
scs = ApplyDetector(Cparams, [ii_im(:)]);

