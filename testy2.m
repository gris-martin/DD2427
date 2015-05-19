close all
clear
clc

im_fname = 'TestImages/one_chris.png';
L = 19;
Cparams = load('classifier_parameters.mat');

% Load image
im = imread(im_fname);
im = rgb2gray(im);
im = double(im);

% Convert to black and white if color
if size(im,3) > 1
    im = rgb2gray(im);
end

% Remove mean and standard deviation (if std not 0) (maybe remove)
% im_array = im(:);
% if std(im_array)
%     im = (im-mean(im_array))/std(im_array);
% else
%     fprintf('Warning: standard deviation = 0 for %s\n', im_fname)
%     im = im-mean(im_array);
% end

sq_im = im.^2;

% Calculate integral images
ii_im = cumsum(cumsum(im),2);
ii_sq_im = cumsum(cumsum(sq_im),2);

size_x = size(im, 2)-L+1;
size_y = size(im, 1)-L+1;
ii_ims = zeros(L^2,size_y);
mus = zeros(1,size_y);
sigmas = zeros(1,size_y);
scs = zeros(size_y,size_x);
for x = 1:(size_x)
    for y = 1:(size_y)
        x
        y
        ii_temp = ii_im(y:(y+L-1),x:(x+L-1));
        ii_sq_temp = ii_sq_im(y:(y+L-1),x:(x+L-1));
        ii_ims(:,y) = ii_temp(:);
        mus(y) = 1/L^2*ii_temp(end,end);
        sigmas(y) = sqrt(1/(L^2-1)*(ii_sq_temp(end,end) - L^2*mus(y)^2));
    end
    scs(:,x) = ApplyDetector(Cparams, ii_ims, mus, sigmas);
end