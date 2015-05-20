function dets = ScanImageOverScale(Cparams, im_path, min_s, max_s, step_s)

im = imread(im_path);
if size(im, 2) > 1
   im = rgb2gray(im);
end
im = double(im);



iter = 1;
for s = min_s : step_s : max_s
    im_temp = imresize(im,s);
    dets_temp = ScanImageFixedSize(Cparams,im_temp);
    dets(iter:(iter+size(dets_temp,1)-1),1:4) = round(dets_temp/s);
    iter = size(dets,1)+1;
end