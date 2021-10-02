function [geom, neg] = EvalNoiseTolerance(state, Q)

range = 100;
def = 10^-6;

% Density operator
max_rho = state*ctranspose(state);
geom = zeros(1,range+1);
neg = zeros(1,range+1);

% Loop for ach value of the mesh
for j = range:-1:0
  p = j/range;
  I = eye(2^Q);
  rho = (1-p)/(2^Q)*I + p*max_rho;
  % Geometric measure
  [E, ~] = GeometricMeasure(rho);
  geom(1,j+1) = E;
  [N, ~] = Negativity(rho);
  neg(1,j+1) = N;
end

x = linspace(0,1, range+1);
vals = x(neg >= def); 1-vals(1)
vals = x(geom >= def); 1-vals(1)

