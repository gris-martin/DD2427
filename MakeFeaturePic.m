function fpic = MakeFeaturePic(ftype, W, H)
% fpic = MakeFeaturePic(ftype, W, H)
% creates a matrix representation of a feature for display with imagesc
% 
% Input     Size/Type   Comment
% ftype      1 x 5      Row vector of the form (type,x,y,w,h), where type
%                       is the type of feature to be extracted; x and y the
%                       starting points; and w and h the size.
%
% W          1 x 1      Width of image
% H          1 x 1      Height of image
% 
% Output    Size/Type   Comment
% fpic       H x W      Matrix representation of the feature described by
%                       ftype. Non-zero elements where feature is located.
%                       As in figure 2 in the manual.

fpic = zeros(W,H);
t = ftype(1);
x = ftype(2);
y = ftype(3);
w = ftype(4);
h = ftype(5);

switch t
    case 1
        fpic(y:(y+h-1), x:(x+w-1)) = -ones(h,w);
        fpic((y+h):(y+2*h-1), x:(x+w-1)) = ones(h,w);
    case 2
        fpic(y:(y+h-1), x:(x+w-1)) = ones(h,w);
        fpic(y:(y+h-1), (x+w):(x+2*w-1)) = -ones(h,w);
    case 3
        fpic(y:(y+h-1), x:(x+w-1)) = ones(h,w);
        fpic(y:(y+h-1), (x+w):(x+2*w-1)) = -ones(h,w);
        fpic(y:(y+h-1), (x+2*w):(x+3*w-1)) = ones(h,w);
    case 4
        fpic(y:(y+h-1), x:(x+w-1)) = ones(h,w);
        fpic(y:(y+h-1), (x+w):(x+2*w-1)) = -ones(h,w);
        fpic((y+h):(y+2*h-1), x:(x+w-1)) = -ones(h,w);
        fpic((y+h):(y+2*h-1), (x+w):(x+2*w-1)) = ones(h,w);
end

end