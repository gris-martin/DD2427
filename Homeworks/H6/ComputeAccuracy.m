function acc = ComputeAccuracy(w, b, X, ys)

n = size(X, 2);
classification = sign(w'*X + b);
correct = sum(classification'.*ys > 0);
acc = correct/n;

end