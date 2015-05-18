function scs = ApplyDetector(Cparams, ii_ims)
% scs = ApplyDetector(Cparams, ii_ims)
% applies the strong classifier to a set of test images.
% 
% Input     Size/Type   Comment
% ii_ims    np x ni     Matrix where each column represents an integral
%                       image. np is the number of pixels and ni is the
%                       number of images.
% 
% Input Cparams is a struct with the following fields:
% Fields    Size/Type   Comment
% alphas    T x 1       Parameter from Algorithm 1
% Thetas    T x 3       Each row is on the form (fs, theta, ps), where fs
%                       is index of the chosen features, theta is the 
%                       threshold and ps is the parity.
% fmat      nf x np     Matrix representation of features, where each
%                       column represents the application of a feature,
%                       such that fmat*ii_im = fs.
% all_ftypes nf x 5     all_ftypes have the columns (type, x, y, w, h) 
%                       where type is the feature type; x and y are 
%                       starting position for the feature (upper left 
%                       corner) and h and w denote the height and width.
% 
% Output    Size/Type   Comment
% scs       ni x 1      Classification score for each image.

inds = Cparams.Thetas(:,1);
thetas = Cparams.Thetas(:,2);
ps = Cparams.Thetas(:,3);
fmat = Cparams.fmat(inds,:);
fs = fmat*ii_ims;

ni = size(fs, 2);
scs = zeros(1,ni);
for i = 1:ni
    scs(i) = Cparams.alphas'*classify(fs(:,i), ps, thetas);
end
end

function h = classify(fs, p, theta)
% Classifies the images according to equation 8.

h = p.*fs < p.*theta;
h = h*2-1; % Make elements of g be either 1 or -1.

end