function [w, b] = TrainSVM(Xtrain, ys, lambda, T)
% [w, b] = TrainSVM(Xtrain, ys, lambda, T)
% implements the Pegasos algorithm for minimizing the stochastic gradient
% descent equation.
% 
% Input     Size/Type   Comment
% Xtrain    d x n       Matrix containing hog descriptors of images. Each 
%                       row corresponds to an image, i.e. d is the number 
%                       of features and n is the number of images.
% ys        n x 1       Row vector containing labels{1,-1} for the 
%                       training images.
% lambda    1 x 1       Training parameter
% T         1 x 1       Number of epochs to run
% 
% Output    Size/Type   Comment
% w         d x 1       Weights
% b         1 x 1       Bias term

d = size(Xtrain, 1); % Number of features
n = size(Xtrain, 2); % Number of images

% Initialization
w = zeros(d, 1);
b = 0;

i = 1;
for epoch = 1:T
    inds = randperm(n); % Create n random indices for current epoch
    for t = 1:n
        ind = inds(t); % Select index
        eta = 1/(lambda*i); % Update learning rate
        
        y = ys(ind);
        x = Xtrain(:,ind);
        
        if (y*(w'*x + b)) < 1
            w = (1 - eta*lambda)*w + eta*y*x;
            b = b + eta*y;
        else
            w = (1 - eta*lambda)*w;
        end
        i = i+1;
    end
    % Normalization
    a = min([1 1/(norm(w)*sqrt(lambda))]);
    w = a*w;
    b = a*b;
end

% Compute accuracy and loss
acc = ComputeAccuracy(w, b, Xtrain, ys);
loss = min(lambda/2*norm(w)^2 + sum(max(0, 1-ys.*(w'*Xtrain + b)')));
fprintf('Accuracy on training set: %3.1f%%\nLoss: %f\n', acc*100, loss);

end