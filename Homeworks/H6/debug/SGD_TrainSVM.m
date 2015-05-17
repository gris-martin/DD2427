function [w, b] = SGD_TrainSVM(Xtrain, ys, lambda, T)

n = size(Xtrain,2);
d = size(Xtrain, 1); % Number of features

% Initialization
w = zeros(d, 1);
b = 0;


i = 1;
for epoch = 1:T
    inds = randperm(n);
    for t = 1:n
        ind = inds(t);
        eta = 1/(lambda*i);
        w = w*(1-eta*lambda);
        y = ys(ind);
        v = ys(ind) * (w' * Xtrain(:,ind) + b);
        if v < 1
            w = w + eta * ys(ind)*Xtrain(:, ind);
            b = b + eta * ys(ind);
        end
        i = i+1;
    end
    a = 1/(sqrt(lambda)*norm(w));
    if a < 1
        w = w*a;
        b = b*a;
    end
    
    fs = w' * Xtrain + b;
    loss = .5 * lambda * norm(w)^2 + sum(max(0, 1 - ys.*fs'));
    acc = ComputeAccuracy(Xtrain, ys, w, b);
    
    if mod(epoch, 10) == 0
        fprintf('Epoch: %d\nLoss: %f\nTrain Acc: %f\n\n', ...
            epoch, loss, acc);
    end
end
