function dets = ScanImageFixedSize(Cparams, im, L)
% ScanImageFixedSize(Cparams, im_path)
% extracts all patches of a fixed size (19 x 19) from an image and 
% searches them for a face.
% 
% Input     Size/Type   Comment
% im_path   string      Path to image file
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
% thresh    1 x 1       If the score from the strong classifier is higher
%                       than thresh, the image will be classified as a
%                       face.
% 
% Output    Size/Type   Comment
% dets      nd x 4      Dets stores information about where the faces are
%                       located. Each row corresponds to a face and is on
%                       the form (x, y, w, h), where x and y denote the
%                       upper left corner, and w and h denote the size of
%                       the patch.

if nargin < 3
    L = 19;
end

% Load image
% im = imread(im_path);
% if size(im, 2) > 1
%    im = rgb2gray(im);
% end
% im = double(im);
sq_im = im.^2; % Square of image

% Calculate integral images
ii_im = cumsum(cumsum(im),2); % Integral image
ii_sq_im = cumsum(cumsum(sq_im),2); % Integral image of the square

% Number of subpatches to extract in x- and y-directions
size_x = size(im, 2) - L;
size_y = size(im, 1) - L;

% Initialization
ii_ims = zeros(L^2,size_y*size_x); % Temporary storage of integral images
mus = zeros(1,size_y*size_x); % Temporary storage of means
sigmas = zeros(1,size_y*size_x); % Temporary storage of standard deviations

if size_x < 3
    disp('Scale too small (image patch larger than image)')
    dets = [];
    return;
    
end

% Loop through all the possible image patches of the specified size
iter = 1;
for x = 2:(size_x+1)
    for y = 2:(size_y+1)
        % Last indices of current subpatch
        x_end = x+L-1; 
        y_end = y+L-1;
        
        % Current subpatches (original and squared)
        ii_temp = ii_im(y:y_end, x:x_end);
        ii_sq_temp = ii_sq_im(y:y_end,x:x_end);

        
        % Sum of pixel values
        ii_sum = ii_temp(end,end) - ...
            ii_im(y_end, x-1) - ...
            ii_im(y-1, x_end) + ...
            ii_im(y-1, x-1);
        ii_sq_sum = ii_sq_temp(end,end) - ...
            ii_sq_im(y_end, x-1) - ...
            ii_sq_im(y-1, x_end) + ...
            ii_sq_im(y-1, x-1);

        % Calculate mean and standard deviation (see task iv)
%         mus(y-1) = 1/L^2*ii_sum;
%         sigmas(y-1) = sqrt(1/(L^2-1)*...
%             (ii_sq_sum - L^2*mus(y-1)^2));
        mus(iter) = 1/L^2*ii_sum;
        sigmas(iter) = sqrt(1/(L^2-1)*...
            (ii_sq_sum - L^2*mus(iter)^2));
        
        % Store current image as an array 
        % (scan through one column at a time before applying detector)
%         ii_ims(:,y-1) = ii_temp(:);
        ii_ims(:,iter) = ii_temp(:);
        iter = iter+1;
    end
    % Apply detector and store scores
%     scs(:,x-1) = ApplyDetector(Cparams, ii_ims, mus, sigmas);
end
scs = ApplyDetector(Cparams, ii_ims, mus, sigmas);
% Save parameters for subpatches where score is higher than threshold
% [row, col] = find(scs > Cparams.thresh);
ind = find(scs > Cparams.thresh)';
dets(:,1:2) = [ceil(ind/size_y), mod(ind,size_y)];
% dets(:,1:2) = [row, col];
dets(:,3:4) = L;

end