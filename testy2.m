
test_inds = setdiff(1:length(TData.ys), TData.train_inds);
ys = TData.ys(test_inds);
scs = ApplyDetector(Cparams,TData.ii_ims(:,test_inds));
thresholds = -5:0.05:5;

% Each row in C corresponds to a threshold
[S, T] = meshgrid(scs, thresholds);
C = S > T;
C = 2*C-1;



pos_tot = sum(ys>0);
neg_tot = sum(ys<0);

YS = repmat(ys', size(C,1),1);
ntp = sum((YS>0).*(C>0),2);
nfp = sum((YS<0).*(C>0),2);

tpr = ntp / pos_tot;
fpr = nfp / neg_tot;

plot(fpr,tpr)