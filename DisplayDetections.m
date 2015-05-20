function DisplayDetections(im_path, dets)

% Load image
im = imread(im_path);

nd = size(dets,1);

image(im); axis equal;
hold on;

for i = 1:nd
    rectangle('Position', dets(i,:), 'LineWidth', 1.5, 'EdgeColor', 'r');
end