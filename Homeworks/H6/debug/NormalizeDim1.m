function nX = NormalizeDim1(X, mu, sig)
nX = zeros(size(X));
for i  = 1:size(X,1)
   
    nX(i, :) = (X(i, :) - mu(i))/sig(i);
    
end