%%  GEOMETRIC MEASURE  Computes the geometric measure of entanglement
%   This function has one required argument:
%     rho: a matrix (density operator)
%
%   [Eg, W] = GeometricMeasure(rho) computes the geometric measure of
%   entanglement for the matrix rho. It is based on the following work: 
%   https://journals.aps.org/pra/abstract/10.1103/PhysRevA.68.042307
%
%   It returns on Eg the geometric measure of entanglement and in W the
%   witness constructed from said measure detecting entangled state defined
%   by rho.
%
%   URL: http://www.qetlab.com/GeometricMeasure

%   requires: IsPPT.m
%   author: Iraitz Montalban (iraitzm@gmail.com)
%   package: QETLAB
%   last updated: July 23, 2021

function [Eg, W] = GeometricMeasure(rho)

%d(i) are the dimensions of the matrix
[d1, ~]= size(rho);
%where dimensions are the dimensinos in each local system, assuming all to
%be two-dimensional
n=log2(d1);
dimensions=2*ones(1,n);

cvx_begin sdp quiet
    % S and X are our placeholders
    variable S(d1,d1) hermitian;
    variable X(d1,d1) complex;
    minimize -trace(X)-trace(ctranspose(X));
    subject to
        [rho X; ctranspose(X) S] >= 0;
        % S must be a density operator
        S >= 0;
        trace(S) == 1;
        % And comply with PPT criteria for separability
        for m=1:n
            PartialTranspose(S, m, dimensions) >= 0;
        end
cvx_end

% Compute maximum fidelity
F = double((trace(X)+trace(ctranspose(X)))/2);
% Build the geometric measure
Eg =1-F^2;

% And witness
if(nargout == 2)
    if (trace(rho^2) < F^2)
        disp("Constructed witness won't detect provided state");
    end
    W = F^2*eye(d1,d1) - rho;
end