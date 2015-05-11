function b_vec = VecBoxSum(x, y, w, h, W, H)
% b_vec = VecBoxSum(x, y, w, h, W, H)
% Computes the row vector b_vec such that b_vec * ii_im(:) equals the
% sum of pixel intensities in a rectangle defined by the inputs.
% 
% Input     Size/Type   Comment
% x, y      1 x 1       Starting value of rectangle (upper left corner)
% w, h      1 x 1       Width and height of rectangle
% W, H      1 x 1       Width and height of image
% 
% Output    Size/Type   Comment
% b_vec     W*H x 1     Vector containing multipliers such that the product
%                       b_vec * ii_im(:) returns the sum of the pixel
%                       inteisities in the region defined by the input
%                       parameters. At most 4 entries will be non-zero.

b_vec = zeros(1,W*H);
if y == 1 && x == 1
    b_vec(VectorInd(h,w,H)) = 1;
elseif y == 1
    b_vec(VectorInd(h,x+w-1,H)) = 1;
    b_vec(VectorInd(h,x-1,H)) = -1;
elseif x == 1
    b_vec(VectorInd(y+h-1,w,H)) = 1;
    b_vec(VectorInd(y-1,w,H)) = -1;
else
    b_vec(VectorInd(y+h-1,x+w-1,H)) = 1;
    b_vec(VectorInd(y-1,x+w-1,H)) = -1;
    b_vec(VectorInd(y+h-1,x-1,H)) = -1;
    b_vec(VectorInd(y-1,x-1,H)) = 1;
end

end

function ind = VectorInd(x,y,H)
% Gives corresponding vector index for image coordinates (x,y), i.e. index
% corresponding to ii_im(x,y)
ind = H*(y-1)+x;
end