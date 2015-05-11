% Performs debug operations for task 1
close all
clear
clc
disp('Ready for debug');

%% Debug point 1 (LoadImage)
disp('Starting debug point 1');
im_fname = 'TrainingImages/FACES/face00001.bmp';
[im, ii_im] = LoadImage(im_fname);
dinfo1 = load('DebugInfo/debuginfo1.mat');
eps = 1e-6;
s1 = sum(abs(dinfo1.im(:) - im(:)) > eps)
s2 = sum(abs(dinfo1.ii_im(:) - ii_im(:)) > eps)
disp('Finished');

%% Debug point 2 (VecBoxSum and VecFeature)
disp('Starting debug point 2');
dinfo2 = load('DebugInfo/debuginfo2.mat');
fs = dinfo2.fs; W = 19; H = 19;
for i = 1:4
    disp([num2str(i) ': ']);
    abs(fs(i) - VecFeature(dinfo2.ftypes(i, :), W, H)*ii_im(:)) > eps
end
disp('Finished');

%% Debug point 3  (EnumAllFeatures and VecAllFeatures)
disp('Starting debug point 3');
dinfo3 = load('DebugInfo/debuginfo3.mat');
fmat = VecAllFeatures(dinfo3.all_ftypes, W, H);
sum(abs(dinfo3.fs - fmat*ii_im(:)) > eps)
disp('Finished');

%% Debug point 4 (LoadImDataDir)
disp('Starting debug point 4');
dirname = 'TrainingImages/FACES/';
dinfo4 = load('DebugInfo/debuginfo4.mat');
ni = dinfo4.ni;
ii_ims = LoadImDataDir(dirname, ni);
fmat = VecAllFeatures(dinfo4.all_ftypes, 19, 19);
sum(sum(abs(fmat - dinfo4.fmat)))
sum(sum(abs(ii_ims - dinfo4.ii_ims)))
disp('Finished');

%% Create data for training
disp('Creating training data');
dinfo5 = load('DebugInfo/debuginfo5.mat');
train_inds = dinfo5.train_inds;
all_ftypes = dinfo5.all_ftypes;
disp('Saving...');
SaveTrainingData(all_ftypes, train_inds, 'training_data.mat');
disp('Finished');