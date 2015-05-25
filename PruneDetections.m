function fdets = PruneDetections(dets,p)

% Initialization
ndets = size(dets,1); % Number of detections
% Matrix where D(i,j) is a measure of how much detection i and j overlap
D = zeros(ndets); 
% Loop over all detections (could be done more efficient by computing only
% half the matrix, but this operation is very fast anyway)
for i1 = 1:ndets
    d1 = dets(i1,:);
    for i2 = 1:ndets
        d2 = dets(i2,:);
        ints = rectint(d1,d2); % Intersection
        union = prod(d1(3:4)) + prod(d2(3:4)) - ints; % Union        
        D(i1,i2) = ints/union; % Measure of overlap
    end
end
[S,C] = graphconncomp(sparse(D>p)); % Group detections according to overlap

% For all groups, replace the original values with the mean
fdets = zeros(S,4);
for i = 1:S
    ind = find(C==i);
    fdets(i,:) = sum(dets(ind,:),1)/length(ind);
end

end