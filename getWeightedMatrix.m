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

function S = getWeightedMatrix(baseCls, I_ncai)

I_ncai = I_ncai(:);
w_sum = sum(I_ncai);

[n, nBC] = size(baseCls);
cntCol = max(baseCls);

S = zeros(n,n);
for k = 1:nBC
    tmp = double(bsxfun(@eq, 1:cntCol(k),baseCls(:,k)));
    idx = tmp * tmp';
    S = S + idx.*I_ncai(k);
end
S = S/w_sum;