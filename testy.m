close all
clear
clc
eps = 1e-6;
TData = load('training_data.mat');

dinfo7 = load('DebugInfo/debuginfo7.mat');
T = dinfo7.T;
Cparams = BoostingAlg(TData, T);
sum(abs(dinfo7.alphas - Cparams.alphas)>eps)
sum(abs(dinfo7.Thetas(:)- Cparams.Thetas(:))>eps)
save('classifier_parameters', '-struct', 'Cparams')
