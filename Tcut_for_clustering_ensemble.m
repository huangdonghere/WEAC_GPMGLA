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

function labels = Tcut_for_clustering_ensemble(B,Nseg)

% B - |X|-by-|Y|, cross-affinity-matrix
% note that |X| = |Y| + |I|

[Nx,Ny] = size(B);
if Ny < Nseg
    error('Need more superpixels!');
end

%%% build the superpixel graph
dx = sum(B,2);
Dx = sparse(1:Nx,1:Nx,1./dx);
Wy = B'*Dx*B;

%%% compute Ncut eigenvectors
% normalized affinity matrix
d = sum(Wy,2);
D = sparse(1:Ny,1:Ny,1./sqrt(d));
nWy = D*Wy*D;
nWy = (nWy+nWy')/2;

% computer eigenvectors
[evec,eval] = eig(full(nWy)); % use eigs for large superpixel graphs  
[~,idx] = sort(diag(eval),'descend');
Ncut_evec = D*evec(:,idx(1:Nseg));

%%% compute the Ncut eigenvectors on the entire bipartite graph (transfer!)
evec = Dx * B * Ncut_evec;

%%% k-means clustering
% extract spectral representations for pixels
% evec = evec(1:prod(img_size),:);
evec = evec(1:(Nx-Ny),:);

% normalize each row to unit norm
evec = bsxfun( @rdivide, evec, sqrt(sum(evec.*evec,2)) + 1e-10 );

% k-means
labels = k_means_II(evec',Nseg);
