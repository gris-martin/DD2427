function SaveTrainingData(all_ftypes, train_inds, s_fn)
% SaveTrainingData(all_ftypes, train_inds, s_fn)
% Loads images from directory and stores their integral images.
%
% Input     Size/Type   Comment
% dirname   string      Path to directory.
% all_ftypes nf x 5     all_ftypes have the columns 
%                       (type, x, y, w, h) where type is the feature type; 
%                       x and y are starting position for the feature 
%                       (upper left corner) and h and w denote the height 
%                       and width.
% train_inds ni x 1     Indices of images to be used in training.
% s_fn      string      Name and path of savefile (.mat).
% 
% Output is saved in the file specified by s_fn
% Output    Size/Type   Comment
% ii_ims    np x ni     Matrix where each column represents an integral
%                       image. np is the number of pixels and ni is the
%                       number of images.
% ys        ni x 1      Labels for the images where +1 represents a face
%                       and -1 a non-face.
% fmat      nf x np     Matrix representation of features, where each
%                       column represents a feature.
% all_ftypes nf x 5     Boundaries for the ftypes, where each row
%                       represents a unique feature. Of the type:       
%                       [type, x, y, w, h]
% W         1 x 1       Width of original image
% H         1 x 1       Heighth of original image

% W and H hardcoded
W = 19;
H = 19;

% 1. Load face images and save in ii_ims
dirname = 'TrainingImages/';
ii_ims = LoadImDataDir([dirname, '/FACES/']);
nfaces = size(ii_ims, 2);

% 2. Load non-face images and concatenate to ii_ims
ii_ims = [ii_ims, LoadImDataDir([dirname, '/NFACES/'])];
nnonfaces = size(ii_ims, 2) - nfaces;
    
% 3. Create ground-truth labels ys
ys = ones(nfaces+nnonfaces, 1);
ys((nfaces+1):nnonfaces) = -1;

% % 4. Compute all_ftypes with EnumAllFeatures
% all_ftypes = EnumAllFeatures(W,H);

% 5. Compute fmat with VecAllFeatures
fmat = VecAllFeatures(all_ftypes, W, H);

% 6. Save to file
save(s_fn, 'ii_ims', 'ys', 'fmat', 'all_ftypes', 'W', 'H', 'train_inds');

end