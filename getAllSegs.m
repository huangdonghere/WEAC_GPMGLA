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

function [bcs, baseClsSegs] = getAllSegs(baseCls)

[N,nBC] = size(baseCls);
% n:    the number of data points.
% nBase:    the number of base clusterings.
% nCls:     the number of clusters (in all base clusterings).


bcs = baseCls;
nClsOrig = max(bcs,[],1);
C = cumsum(nClsOrig); 
bcs = bsxfun(@plus, bcs,[0 C(1:end-1)]);
nCls = nClsOrig(end)+C(end-1);
baseClsSegs = zeros(nCls,N);

for i=1:nBC 
    if i == 1
        startK = 1;
    else
        startK = (C(i-1)+1);
    end
    endK = C(i);
    searchVec = startK:endK;
    F = bsxfun(@eq,bcs(:,i),searchVec);
    baseClsSegs(searchVec,:) = F';
end






