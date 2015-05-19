function [theta, p, err] = LearnWeakClassifier(ws, fs, ys)
% [theta, p, err] = LearnWeakClassifier(ws, fs, ys)
% Learns a weak classifier from the feature responses fs, weights ws and
% labels ys.
%
% Input     Size/Type   Comment
% ws        n x 1      	Weights associated with each feature response.
% fs        n x 1       The feature responses
% ys        n x 1       Labels for the feature responses, where +1 denotes
%                       a positive example and -1 denotes a negative one.
% Note: n = number of feature responses (i.e. images)
% 
% Output    Size/Type   Comment
% theta     1 x 1       Threshold value (see equation 8 in manual)
% p         1 x 1       Parity value, eighet +1 or -1.
% err       1 x 1       Error value of classifier when applied to training
%                       data.

% Calculate weighted means
a = (ws.*fs)';
ws_t = ws';
ys_p = 1+ys;
ys_n = 1-ys;
mu_p = (a*ys_p)/(ws_t*(ys_p));
mu_n = (a*ys_n)/(ws_t*(ys_n));

% Claculate threshold theta (middle of means)
theta = (mu_p + mu_n)/2;

% Calculate error
% err_n = sum(ws.*abs(ys - classify(fs, -1, theta)))/2;
err_n = ws_t*abs(ys_p - classify(fs, -1, theta))/2;
% err_p = sum(ws.*abs(ys - classify(fs, 1, theta)))/2

% Assign parity to minimize error
if err_n < 0.5
    p = -1;
    err = err_n;
else
    p = 1;
    err = 1-err_n;
end

end


function g = classify(fs, p, theta)
% Classifies the images according to equation 8.

g = p*fs < p*theta;
g = g*2; % Make elements of g be either 1 or -1.

end