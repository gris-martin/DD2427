function all_ftypes = EnumAllFeatures(W,H)

% all_ftypes = EnumAllFeatures(W,H)
% Calculates boundaries for all possible feature types and locations in an
% image with width W and height H. all_ftypes have the columns 
% (type, x, y, w, h) where type is the feature type; x and y are starting 
% position for the feature (upper left corner) and h and w denote the 
% height and width.
%
% Size of all_ftypes: nf x 5, where nf is the total number of features


all_ftypes = zeros(W^2*H^2,5);


cf = 0;

type = 1;
for w = 1:W-2
    for h = 1:floor(H/2)-2
        for x = 2:W-w
            for y = 2:H-2*h
                cf = cf + 1;
                all_ftypes(cf,:) = [type x y w h];
            end
        end
    end
end

type = 2;
for w = 1:floor(W/2)-2
    for h = 1:H-2
        for x = 2:W-2*w
            for y = 2:H-h
                cf = cf + 1;
                all_ftypes(cf,:) = [type x y w h];
            end
        end
    end
end


type = 3;
for w = 1:floor(W/3)-2
    for h = 1:H-2
        for x = 2:W-3*w
            for y = 2:H-h
                cf = cf + 1;
                all_ftypes(cf,:) = [type x y w h];
            end
        end
    end
end

type = 4;
for w = 1:floor(W/2)-2
    for h = 1:floor(H/2)-2
        for x = 2:W-2*w
            for y = 2:H-2*h
                cf = cf + 1;
                all_ftypes(cf,:) = [type x y w h];
            end
        end
    end
end

all_ftypes = all_ftypes(1:cf,:);