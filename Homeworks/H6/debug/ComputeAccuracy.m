function acc = ComputeAccuracy(X, ys, w, b)

y_est = sign(w' * X + b);
nc = sum(y_est' == ys);
acc = nc/size(X,2);

end