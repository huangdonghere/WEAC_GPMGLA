%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build the bipartite graph for the GP-MGLA method.
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

function B = getBipartiteGraph(bcs, bcsSegs, I_ncai, alpha)

% n:    the number of data points.
% nBase:    the number of base clusterings.
% nCls:     the total number of clusters (in all base clusterings).

[nCls,n] = size(bcsSegs);

W_Y = makeWeightsBtwCls_SACT(bcs, bcsSegs, I_ncai);

W_XY = zeros(nCls, n);
sim = I_ncai'.*alpha;
bcsIdx = bsxfun(@plus, bcs, (0:n-1)'*nCls);
bcsIdx = reshape(bcsIdx',numel(bcsIdx),1);
W_XY(bcsIdx) = repmat(sim,1,n);
B = [W_XY';W_Y];