close all
clear
clc

D = load('pedestrian_training.mat');

lambda = .0001;
b0 = 0;
max_iter = 40;
cellSize = 4;

trainX = ExtractHog(D.ims, cellSize);
trainy = D.y;

[trainX, train_m, train_s] = NormalizeDim(trainX);

w0 = zeros(size(trainX, 1), 1);
[w, b] = SGD_TrainSVM(trainX, trainy, lambda, max_iter);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
