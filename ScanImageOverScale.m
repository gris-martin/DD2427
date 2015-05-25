function dets = ScanImageOverScale(Cparams, im_path, min_s, max_s, step_s)

% Convert to black and white
im = imread(im_path);
if size(im, 2) > 1
   im = rgb2gray(im);
end
im = double(im);

% Resize image and run the fixed size scanner for different scales
iter = 1;
for s = min_s : step_s : max_s
    im_temp = imresize(im,s); % Scaled image
    % Detected faces at current scale
    dets_temp = ScanImageFixedSize(Cparams,im_temp);
    % Transform parameters back to original scale and add to list
    dets(iter:(iter+size(dets_temp,1)-1),1:4) = round(dets_temp/s);
    iter = iter+size(dets_temp,1);

    % Some output
    disp(['Scale ' num2str(s) ' done.'...
        ' Found ' num2str(size(dets,1)) ' faces'])
end