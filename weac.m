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

function [resultCls_sl, resultCls_cl, resultCls_al] = weac(baseCls, I_ncai, clsNums)

%  Get the weighted co-association matrix.
S = getWeightedMatrix(baseCls, I_ncai);

d = stod(S); clear S %convert similarity matrix to distance vector
% single linkage
Zsl = linkage(d,'single');
% complete linkage
Zcl = linkage(d,'complete');
% average linkage 
Zal = linkage(d,'average'); clear d

resultCls_sl = [];
resultCls_cl = [];
resultCls_al = [];
for K = clsNums
    resultCls_sl = [resultCls_sl cluster(Zsl,'maxclust',K)];
    resultCls_cl = [resultCls_cl cluster(Zcl,'maxclust',K)];
    resultCls_al = [resultCls_al cluster(Zal,'maxclust',K)];
end