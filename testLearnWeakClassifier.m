close all
clear
clc

% Test program for LearnWeakClassifier

% Load some data (a single feature, i.e. a single column of fmat)
TData = load('training_data.mat');
ftype_vec = TData.fmat(12028,:);
train_inds = TData.train_inds;
ii_ims = TData.ii_ims(:,train_inds);
fs = ftype_vec*ii_ims;
ys = TData.ys(train_inds);

% Calculate initial weights
n = numel(ys); % Number of images
m = sum(ys < 0); % Number of non-face images (

w_n = (ys < 0)/(2*m); % Negative weights (i.e. yi = -1)
w_p = (ys > 0)/(2*(n-m)); %Positive weights (i.e. yi = +1)
ws = w_n + w_p;
ws = ws/sum(ws);

[theta, p, err] = LearnWeakClassifier(ws, fs', ys);

%Create histogram of feature responses
ind_p = find(ys > 0);
ind_n = find(ys < 0);
[y_p, x_p] = hist(fs(ind_p)); % Faces
[y_n, x_n] = hist(fs(ind_n)); % Non-faces

% Normalization
y_p = y_p/sum(y_p);
y_n = y_n/sum(y_n);

% Plot faces curve
p1 = plot(x_p, y_p, 'b');
hold on
plot(x_p, y_p, 'bo')

% Plot non-faces curve
p2 = plot(x_n, y_n, 'r');
plot(x_n, y_n, 'ro')

% Plot decision boundary
legend([p1, p2], {'faces', 'non-faces'});
plot([theta theta], ylim, 'k')

xlabel('Feature response (fs)');
ylabel('Frequency');
title('Histogram of feature responses, with decision boundary')