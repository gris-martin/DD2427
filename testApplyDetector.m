close all
clear
clc


% Test the detector
%% Load strong classifier parameters
TData = load('training_data.mat');
dinfo7 = load('DebugInfo/debuginfo7.mat');
T = dinfo7.T;
% Cparams = BoostingAlg(TData, T);
Cparams = load('classifier_parameters.mat');

%% Apply detector
im = double(imread('TrainingImages/FACES/face00001.bmp'));
% im = (im-mean(im(:)))/std(im(:));
% [im, ii_im] = LoadImage('TrainingImages/FACES/face00001.bmp');
ii_im = cumsum(cumsum(im),2);
sq_im = im.^2;
ii_sq_im = cumsum(cumsum(sq_im),2);
L = size(im,1);
mu = 1/L^2*ii_im(end,end);
sigma = sqrt(1/(L^2-1)*(ii_sq_im(end,end) - L^2*mu^2));

scs = ApplyDetector(Cparams, [ii_im(:), ii_im(:)], [mu mu], [sigma sigma]);

