close all
clear
clc

im_fname = 'TestImages/big_one_chris.png';
Cparams = load('classifier_parameters.mat');
Cparams.thresh = 3.0; % Change threshold

min_s = 0.6;
max_s = 1.3;
step_s = 0.06;
dets = ScanImageOverScale(Cparams,im_fname,min_s,max_s,step_s);

% Display the detected faces on the original image
DisplayDetections(im_fname,dets)