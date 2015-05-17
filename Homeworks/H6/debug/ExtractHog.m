function X = ExtractHog(ims, cellSize)

ni = length(ims);
X = [];
for i = 1:ni;
    im = single(ims{i})/256;
    hog = vl_hog(im, cellSize);
    if i == 1
        X = zeros(numel(hog), ni);
    end
    X(:,i) = hog(:);
end

end