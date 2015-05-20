close all
clear
clc

im_fname = 'TestImages/one_chris.png';
L = 19;
Cparams = load('classifier_parameters.mat');
dets = ScanImageFixedSize(Cparams,im_fname);

DisplayDetections(im_fname,dets);