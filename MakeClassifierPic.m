function cpic = MakeClassifierPic(all_ftypes, chosen_f, alphas, ps, W, H)
% cpic = MakeClassifierPic(all_ftypes, chosen_f, alphas, ps, W, H)
% Creates a matrix representation of the weighted sum of all the features
% to be used in the classifier. To be used with e.g. imagesc.
% 
% Input     Size/Type   Comment
% all_ftypes nf x 5     all_ftypes have the columns (type, x, y, w, h) 
%                       where type is the feature type; x and y are 
%                       starting position for the feature (upper left 
%                       corner) and h and w denote the height and width.
% chosen_f  nc x 1      Row vector where each element corresponds to a
%                       feature in all_ftypes. nc denotes the number of
%                       chosen features.
% alphas    nc x 1
% ps        nc x 1      Alphas and ps are used to calculate the weights
%                       with ws = alphas.*ps.
% W         1 x 1       Width of image
% H         1 x 1       Height of image
% 
% Output    Size/Type   Comment
% cpic       H x W      Matrix representation of the chosen features. 
%                       Non-zero elements where features are located. As 
%                       in figure 2 b) in the manual.

ws = alphas .* ps;
cpic = zeros(H, W);
for i = 1:length(chosen_f)
    cpic = cpic + ws(i)*MakeFeaturePic(all_ftypes(chosen_f(i),:), W, H);
end