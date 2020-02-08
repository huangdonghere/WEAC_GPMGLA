%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the normalized crowd agreement index.
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

function NCAI = getNCAI(baseCls)


cnt = size(baseCls,2);
ClsAfnyWrtNMI = zeros(cnt, cnt); % it is symmetric.
for i = 1 : cnt
    for j = i+1 : cnt
        ClsAfnyWrtNMI(i,j) = NMImax(baseCls(:,i), baseCls(:,j));
    end
end

ClsAfnyWrtNMI = ClsAfnyWrtNMI + ClsAfnyWrtNMI';

CAI = (sum(ClsAfnyWrtNMI)./(cnt-1))';
NCAI = CAI./max(CAI(:));