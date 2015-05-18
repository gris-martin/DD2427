function ComputeROC(Cparams, Tdata)

test_inds = setdiff(1:length(ys), Tdata.train_inds);
scs = ApplyDetector(Cparams,Tdata.ii_ims(:,test_inds));
thresholds = 0:0.05:5;

% Each row in C corresponds to a threshold
[S, T] = meshgrid(scs, thresholds);
C = S > T;

end