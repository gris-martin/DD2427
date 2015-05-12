close all
clear
clc

% Test program for LearnWeakClassifier

% Load some data
TData = load('training_data.mat');
ftype = TData.fmat(12028,:);
train_inds = TData.train_inds;
ii_ims = TData.ii_ims(:,train_inds);
% ii_ims = TData.ii_ims;
fs = ftype*ii_ims;
ys = TData.ys(train_inds);
% ys = TData.ys;

% Calculate initial weights
n = numel(ys);
m = sum(ys < 0);

w_n = (ys < 0)/(2*m); % Negative weights
w_p = (ys > 0)/(2*(n-m)); %Positive weights
ws = w_n + w_p;
ws = ws/sum(ws);

[theta, p, err] = LearnWeakClassifier(ws, fs', ys);

%Create histogram of feature responses
ind_p = find(ys > 0);
ind_n = find(ys < 0);
[y_p, x_p] = hist(fs(ind_p));
[y_n, x_n] = hist(fs(ind_n));

y_p = y_p/sum(y_p);
y_n = y_n/sum(y_n);
p1 = plot(x_p, y_p, 'b');
hold on
plot(x_p, y_p, 'bo')

p2 = plot(x_n, y_n, 'r');
plot(x_n, y_n, 'ro')

legend([p1, p2], {'faces', 'non-faces'});
plot([theta theta], ylim, 'k')
