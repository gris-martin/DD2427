function [im, ii_im] = LoadImage(im_fname)
% [im, ii_im] = LoadImage(im_fname)
% Loads and normalizes image im from path im_fname and calculates integral
% image ii_im.
% 
% Input     Size/Type   Comment
% im_fname  string      Path to image file
% 
% Output    Size/Type   Comment
% im        W x H       Normalized image
% ii_im     W x H       Integral image


% Load image
im = double(imread(im_fname));

% Convert to black and white if color
if size(im,3) > 1
    im = rgb2gray(im);
end


% Remove mean and standard deviation (if std not 0)
im_array = im(:);
if std(im_array)
    im = (im-mean(im_array))/std(im_array);
else
    fprintf('Warning: standard deviation = 0 for %s\n', im_fname)
    im = im-mean(im_array);
end

% Calculate integral image
ii_im = cumsum(cumsum(im),2);

end