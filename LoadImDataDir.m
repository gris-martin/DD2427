function ii_ims = LoadImDataDir(dirname, ni)
% fmat = VecAllFeatures(all_ftypes, W, H)
% Loads images from directory and stores their integral images.
%
% Input     Size/Type   Comment
% dirname   string      Path to directory.
% ni        1 x 1       Optional argument. Number of images to be loaded. 
%                       If not specified all the images in the directory
%                       will be loaded.
% 
% Output    Size/Type   Comment
% ii_ims    np x ni     Matrix where each column represents an integral
%                       image. np is the number of pixels and ni is the
%                       number of images.

face_fnames = dir([dirname, '*.bmp']);
if nargin < 2
    ni = size(face_fnames, 1);
end

% Load first image to determine size of image (for preallocation)
[~, ii_im] = LoadImage([dirname, face_fnames(1).name]);
np = numel(ii_im);
ii_ims = zeros(np, ni);
ii_ims(1:np, 1) = ii_im(:);

for i = 2:ni
    [~, ii_im] = LoadImage([dirname, face_fnames(i).name]);
    ii_ims(1:np, i) = ii_im(:);
end

end

