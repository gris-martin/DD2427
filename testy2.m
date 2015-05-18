close all
clear
clc

im_fname = 'TestImages/one_chris.png';

% Load image
im = double(imread(im_fname));

% Convert to black and white if color
if size(im,3) > 1
    im = rgb2gray(im);
end

% Remove mean and standard deviation (if std not 0) (maybe remove)
im_array = im(:);
if std(im_array)
    im = (im-mean(im_array))/std(im_array);
else
    fprintf('Warning: standard deviation = 0 for %s\n', im_fname)
    im = im-mean(im_array);
end

sq_im = im.^2;

% Calculate integral images
ii_im = cumsum(cumsum(im),2);
ii_sq_im = cumsum(cumsum(sq_im),2);


for x = 1:size(im, 2)
    for y = 1:size(im, 1)
        
    end
end