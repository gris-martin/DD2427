close all
close all
clear
clc
eps = 1e-6;
TData = load('training_data.mat');

%% Train strong classifier with 100 weak ones
dinfo7 = load('DebugInfo/debuginfo7.mat');
% T = dinfo7.T;
T = 100;
Cparams100 = OldBoostingAlg(TData, T);
save('classifier_parameters100', '-struct', 'Cparams100')

%% Train strong classifier with 10 weak ones
T = 10;
Cparams10 = OldBoostingAlg(TData, T);
save('classifier_parameters_10', '-struct', 'Cparams10');