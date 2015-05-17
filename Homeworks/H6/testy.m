close all
clear
clc

ims_train = load('pedestrian_training.mat');
ims = ims_train.ims;

n = size(ims, 2); %Number of images
d = 9*5*31; %Size of hog descriptor
Xtrain = zeros(d,n);
for i = 1:n;
    im = single(ims{i})/256;
    hog = vl_hog(im, 4);
    Xtrain(:,i) = hog(:);
end
w0 = zeros(d, 1);
b0 = 0;

ys = ims_train.y;
% [w, b] = SGD_TrainSVM(Xtrain, ys, 0.0001, 40);
disp('Hemmagjord')
[w, b] = TrainSVM(Xtrain, ys, 0.0001, 40);

%%

classification = sign(w'*Xtrain + b);

correct = sum(classification'.*ys > 0)
incorrect = sum(classification'.*ys < 0)

acc = correct/n