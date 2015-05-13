close all
clear
clc
eps = 1e-6;
TData = load('training_data.mat');

%% Debug task 1 (BoostingAlg (and LearnWeakClassifier) with 1000 features)
dinfo6 = load('DebugInfo\debuginfo6.mat');
T = dinfo6.T;

t_inds = 1:1000;
Cparams = BoostingAlg(TData, T, t_inds);

sum(abs(dinfo6.alphas - Cparams.alphas) > eps)
sum(abs(dinfo6.Thetas(:) - Cparams.Thetas(:)) > eps)

%% Debug task 2 (BoostingAlg with all features)
dinfo7 = load('DebugInfo/debuginfo7.mat');
T = dinfo7.T;
Cparams = BoostingAlg(TData, T);
sum(abs(dinfo7.alphas - Cparams.alphas)>eps)
sum(abs(dinfo7.Thetas(:)- Cparams.Thetas(:))>eps)