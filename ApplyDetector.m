function scs = ApplyDetector(Cparams, ii_ims, mus, sigmas)
% scs = ApplyDetector(Cparams, ii_ims)
% applies the strong classifier to a set of test images.
% 
% Input     Size/Type   Comment
% ii_ims    np x ni     Matrix where each column represents an integral
%                       image. np is the number of pixels and ni is the
%                       number of images.
% sq_ii_ims np x ni     The integral image of the squared version of the
%                       original image.
% mus       1 x ni      Means of images
% sigmas    1 x ni      Standard deviations of images
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
% §
% Output    Size/Type   Comment
% scs       ni x 1      Classification score for each image.

% Normalization
% L_sq = L^2;
% np = size(ii_ims, 1);
% mus = repmat(mean(ii_ims),np,1);
% stds = repmat(mean(ii_ims),np,1);
% ii_ims = (ii_ims - mus)./stds;

% Load data
inds = Cparams.Thetas(:,1);
thetas = Cparams.Thetas(:,2);
ps = Cparams.Thetas(:,3);
fmat = Cparams.fmat(inds,:);
all_ftypes = Cparams.all_ftypes(inds,:);

% Feature vector (nf x ni; i.e. each column corresponds to an image)
fs = fmat*ii_ims;
nf = size(fs,1);
ni = size(fs,2);
if nargin > 2
    % Normalization (See Task IV)
    type3_inds = find(all_ftypes(:,1) == 3); % Store indices of third type
    type3_wh = all_ftypes(type3_inds,[4 5]); % Get width and heigth
    type3_wh = prod(type3_wh,2); % Multiply width and height
    type3_wh = repmat(type3_wh,1,ni); % Repeat for all images
    
    S = repmat(sigmas,nf,1); % Repeat sigmas for all features
    M = repmat(mus,numel(type3_inds),1); % Repeat mus for features of type 3
    
    fs = fs./S;
    S = S(type3_inds,:);
    fs(type3_inds,:) = fs(type3_inds,:)+type3_wh.*M./S;
end

% Apply the strong classifier to calculate scores (to be thresholded)
P = repmat(ps,1,ni);
T = repmat(thetas,1,ni);
H = P.*fs < P.*T;
H = H*2-1;
scs = Cparams.alphas'*H;
% scs = zeros(1,ni);
% for i = 1:ni
%     scs(i) = Cparams.alphas'*classify(fs(:,i), ps, thetas);
% end
% 
end

% function h = classify(fs, p, theta)
% % Classifies the images according to equation 8.
% 
% h = p.*fs < p.*theta;
% h = h*2-1; % Make elements of g be either 1 or -1.
% 
% end