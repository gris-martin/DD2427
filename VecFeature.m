function ftype_vec = VecFeature(ftype, W, H)
% ftype_vec = VecFeature(ftype, W, H)
% Computes the feature vector ftype-vec, defined by ftype, that can be used
% together with the integral image to calculate a feature. (see output)
%
% Input      Size/Type   Comment
% ftype      1 x 5      Row vector of the form (type,x,y,w,h), where type
%                       is the type of feature to be extracted; x and y the
%                       starting points; and w and h the size.
%
% W          1 x 1      Width of image
% H          1 x 1      Height of image
%
% Output     Size/Type  Comment
% ftype_vec  H*W x 1    Features represented in a column vector. Each
%                       element corresponds to an integral image value.
%                       f = ftype_vec*ii_im(:) gives the value of the
%                       feature defined by the input ftype.

t = ftype(1);
x = ftype(2);
y = ftype(3);
w = ftype(4);
h = ftype(5);
ftype_vec = zeros(H*W,1);

switch t
    case 1
        ftype_vec = VecBoxSum(x, y, w, h, W, H) ...
            - VecBoxSum(x, y+h, w, h, W, H);
    case 2
        ftype_vec = VecBoxSum(x+w, y, w, h, W, H) ...
            - VecBoxSum(x, y, w, h, W, H);
    case 3
        ftype_vec = VecBoxSum(x+w, y, w, h, W, H) ...
            - VecBoxSum(x, y, w, h, W, H) ...
            - VecBoxSum(x+2*w, y, w, h, W, H);
    case 4
        ftype_vec = VecBoxSum(x+w, y, w, h, W, H) ...
            + VecBoxSum(x, y+h, w, h, W, H) ...
            - VecBoxSum(x, y, w, h, W, H) ...
            - VecBoxSum(x+w, y+h, w, h, W, H);
end