close all
close all
clear
clc
eps = 1e-6;
TData = load('training_data.mat');

%% Debug task 2 (BoostingAlg with all features)
dinfo7 = load('DebugInfo/debuginfo7.mat');
% T = dinfo7.T;
T = 100;
Cparams = BoostingAlg(TData, T);
% sum(abs(dinfo7.alphas - Cparams.alphas)>eps)
% sum(abs(dinfo7.Thetas(:)- Cparams.Thetas(:))>eps)
save('classifier_parameters', '-struct', 'Cparams')
% %%
% Cparams2 = BoostingAlgTest(TData,T);
% sum(abs(dinfo7.alphas - Cparams2.alphas)>eps)
% sum(abs(dinfo7.Thetas(:)- Cparams2.Thetas(:))>eps)