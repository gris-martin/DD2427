function scs = ApplyDetector(Cparams, ii_ims)
% scs = ApplyDetector(Cparams, ii_ims)
% applies the strong classifier to a set of test images.
% 
% Output    Size/Type   Comment
% ii_ims    np x ni     Matrix where each column represents an integral
%                       image. np is the number of pixels and ni is the
%                       number of images.
% 
% Cparams is a struct with the following fields:
% Fields    Size/Type   Comment
% alphas    T x 1       Parameter from Algorithm 1
% Thetas    T x 3       Each row is on the form (fs, theta, ps), where fs
%                       is the features chosen, theta is the threshold and
%                       ps is the parity.
% fmat      nf x np     Matrix representation of features, where each
%                       column represents a feature.
% all_ftypes nf x 5     all_ftypes have the columns (type, x, y, w, h) 
%                       where type is the feature type; x and y are 
%                       starting position for the feature (upper left 
%                       corner) and h and w denote the height and width.
% 
% Output    Size/Type   Comment
% scs       ni x 1      Classification score for each image.

fmat = Cparams.fmat;
fs = fmat*ii_ims;

end

function h = classify(fs, p, theta)
% Classifies the images according to equation 8.

g = p*fs < p*theta;
g = g*2-1; % Make elements of g be either 1 or -1.

end

