%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The demo of the WEAC and GP-MGLA methods.
% Written by Dong Huang, optimized by Nejc Ilc.
% Version 3.0. Aug. 14, 2015.
%
% If you use this code in your work, please cite the following paper:
%
% Dong Huang, Jian-Huang Lai, Chang-Dong Wang. 
% Combining Multiple Clusterings via Crowd Agreement Estimation and Multi-
% Granularity Link Analysis. Neurocomputing, 2015, 170, pp.240-250.
%
% Special thanks to Mr. Nejc Ilc from University of Ljubljana, who helped 
% optimize the matlab code for improving running speed.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function SACT = makeWeightsBtwCls_SACT(bcs, bcsSegs, I_ncai)

nCls = size(bcsSegs,1);

maxBcs = max(bcs);
minBcs = min(bcs);

bcsSegs_numel = sum(bcsSegs,2);

W_Y = eye(nCls);
nClsIdx = find(bcsSegs_numel);
for i = nClsIdx(:)'
    j = i+1:nCls;
    j = j(bcsSegs_numel(j)~=0);
    interCnt = sum(bsxfun(@and, bcsSegs(i,:), bcsSegs(j,:)),2);
    W_Y(i,j) = interCnt ./ (bcsSegs_numel(i)+bcsSegs_numel(j)-interCnt);    
end

W_Y = W_Y + W_Y';
W_Y(1:nCls+1:nCls^2) = W_Y(1:nCls+1:nCls^2) - 2 + (bcsSegs_numel ~= 0)';
W_Y_binary = (W_Y>0);

nClsVec = (1:nCls)';
allWhichBcs = bsxfun(@le,nClsVec,maxBcs) & bsxfun(@ge,nClsVec,minBcs); 
I_ncaiBcs = allWhichBcs*I_ncai;

SACT_sum = zeros(size(W_Y));
for i = 1:nCls
    j = i+1:nCls;
    commonNeighbors = bsxfun(@and, W_Y_binary(:,i),W_Y_binary(:,j));
    weightedTerm = bsxfun(@times,commonNeighbors,I_ncaiBcs);    
    SACT_sum(i,j) = sum(weightedTerm.* bsxfun(@min,W_Y(:,i), W_Y(:,j)),1);
end
diagWeight = sum(bsxfun(@times,W_Y_binary,I_ncaiBcs) .* W_Y);
SACT_sum = SACT_sum + SACT_sum';
SACT_sum(1:nCls+1:nCls^2) = SACT_sum(1:nCls+1:nCls^2) + diagWeight;
SACT = SACT_sum / max(SACT_sum(:));
SACT(1:nCls+1:nCls^2) = 1;