close all
clear
clc
Cparams = load('classifier_parameters_100.mat');

%% Test ScanImageFixedSize on one_chris.png
Cparams.thresh = 3;
p = 0.5;

im_fname = 'TestImages/one_chris.png';
L = 19;
im = imread(im_fname);
im = double(rgb2gray(im));

dets = ScanImageFixedSize(Cparams,im,L);
fdets = PruneDetections(dets,p);
figure;
DisplayDetections(im_fname,fdets);

%% Test ScanImageOverScale on big_one_chris.png
Cparams.thresh = 3;
p = 0.5;
min_s = 0.6;
max_s = 1.2;
step_s = 0.1;

im_fname = 'TestImages/big_one_chris.png';
% im = imresize(imread(im_fname),1.2);
% im = double(rgb2gray(im));

dets = ScanImageOverScale(Cparams, im_fname, min_s, max_s, step_s);
fdets = PruneDetections(dets,p);
figure;
DisplayDetections(im_fname,fdets);

%% Other test images

im_fname = 'TestImages/facepic2.jpg';

Cparams.thresh = 4.5; % Change threshold
min_s = 0.02;
max_s = 0.7;
step_s = 0.02;
p = 0.2; % Pruning

dets = ScanImageOverScale(Cparams,im_fname,min_s,max_s,step_s);
iter = 1;


dets_pruned = PruneDetections(dets,p);

% Display the detected faces on the original image
figure;
DisplayDetections(im_fname,dets_pruned)
