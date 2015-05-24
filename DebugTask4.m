close all
clear
clc

im_fname = 'TestImages/dreaner.jpg';
Cparams = load('classifier_parameters.mat');
Cparams.thresh = 2; % Change threshold

% im_fname_small = 'TestImages/one_chris.png';
% im = imread(im_fname_small);
% if size(im, 2) > 1
%    im = rgb2gray(im);
% end
% im = double(im);
% dets = ScanImageFixedSize(Cparams,im,19);

min_s = 0.1;
max_s = 1;
step_s = 0.1;
dets = ScanImageOverScale(Cparams,im_fname,min_s,max_s,step_s);

% Display the detected faces on the original image
DisplayDetections(im_fname,dets)