function [nX, mu, s] = NormalizeDim(X)
mu = mean(X, 2);
s = std(X, 0, 2);
nX = NormalizeDim1(X, mu, s);
