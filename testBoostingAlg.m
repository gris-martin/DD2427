close all
clear
clc

% Test the BoostingAlg function

TData = load('training_data.mat');
T = 3;
t_inds = 1:1000;

Cparams = BoostingAlg(TData, T, t_inds);
% Cparams = BoostingAlg(TData, T);

%%

for i = 1:T
    subplot(1,T,i);
    fpic = MakeFeaturePic(TData.all_ftypes(Cparams.Thetas(i,1), :), 19, 19);
    imagesc(fpic); colormap gray; axis equal;
end

figure;
cpic = MakeClassifierPic(TData.all_ftypes, Cparams.Thetas(:,1), Cparams.alphas, Cparams.Thetas(:,3), 19, 19);
imagesc(cpic); colormap gray; axis equal;

%%
eps = 1e-6;
dinfo6 = load('DebugInfo\debuginfo6.mat');
T = dinfo6.T;
Cparams = BoostingAlg(TData, T, t_inds);
sum(abs(dinfo6.alphas - Cparams.alphas) > eps)
sum(abs(dinfo6.Thetas(:) - Cparams.Thetas(:)) > eps)