close all
clear
clc

TData = load('training_data.mat');
Cparams100 = load('classifier_parameters_100.mat');
Cparams10 = load('classifier_parameters_10.mat');

%% ROC curves
figure;
[fpr10, tpr10] = ComputeROC(Cparams10,TData);
hold on
[fpr100, tpr100, thresholds] = ComputeROC(Cparams100,TData,'r');
legend('10 weak classifiers', '100 weak classifiers')

%% Classification comparison
im_fname = 'TestImages/Student1.jpg';

Cparams10.thresh = 3;
Cparams100.thresh = 4.5;
min_s = 0.05;
max_s = 0.6;
step_s = 0.05;
% min_s = 1;
% max_s = 1;
% step_s = 1;
p = 0.2; % Pruning

dets10 = ScanImageOverScale(Cparams10,im_fname,min_s,max_s,step_s);
dets100 = ScanImageOverScale(Cparams100,im_fname,min_s,max_s,step_s);

dets10_pruned = PruneDetections(dets10,p);
dets100_pruned = PruneDetections(dets100,p);

% Display the detected faces on the original image
figure;
DisplayDetections(im_fname,dets10_pruned)
title('10 weak classifiers')
figure;
DisplayDetections(im_fname,dets100_pruned)
title('100 weak classifiers')
