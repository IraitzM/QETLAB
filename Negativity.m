%%  Negativity Computes the negativity measure of entanglement
%   This function has one required argument:
%     rho: a matrix (density operator)
%
%   [N, W] = Negativity(rho) computes the multipartite negativity of
%   entanglement for the matrix rho. It is based on the following work: 
%   https://arxiv.org/abs/1010.6049
%
%   It returns on N the negativity of entanglement and in W the
%   witness constructed from said measure detecting entangled state defined
%   by rho.
%
%   URL: http://www.qetlab.com/GeometricMeasure

%   requires: PartialTranspose.m
%   author: Iraitz Montalban (iraitzm@gmail.com)
%   package: QETLAB
%   last updated: July 23, 2021

function [N,W] = Negativity(rho)

%d(i) are the dimensions of the matrix
[d1, d2]= size(rho);
%where dimensions are the dimensinos in each local system, assuming all to
%be two-dimensional
n=log2(d1);
dimensions=2*ones(1,n);

cvx_begin sdp quiet
    % W is the witness to be constructed
    variable W(d1,d2) hermitian;
    % P being part of the composable witness for all subsystems
    variable P(d1,d2,2^(n-1)) hermitian;
    minimize trace(rho*W);
    subject to
        % Half of the possible bipartitions given they are complementary
        for m=1:2^(n-1)-1
            % Obtain M bipartiton
            dims = find(dec2bin(m,n) == '1');
            % P
            P(:,:,m) >= 0;
            eye(d1,d1) - P(:,:,m) >= 0;
            % Q
            Q = W-P(:,:,m);
            PartialTranspose(Q, dims, dimensions) >= 0;
            eye(d1,d1) - PartialTranspose(Q, dims, dimensions) >= 0;
        end
cvx_end

% Negativity
N = -trace(W*rho);

