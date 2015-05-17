function X = ComputeHog(ims)

% Convert to single and compute hog descriptor
n = size(ims, 2); %Number of images
d = 9*5*31; %Size of hog descriptor (hard coded, sorry!)
X = zeros(d,n);
for i = 1:n;
    im = single(ims{i})/256;
    hog = vl_hog(im, 4);
    X(:,i) = hog(:);
end

end