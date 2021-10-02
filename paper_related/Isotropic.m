range = 100;

% Isotropic state
state = Bell(0);
max_rho = state*ctranspose(state);

geom = zeros(1,range+1);
geom_w = zeros(1,range+1);
neg = zeros(1,range+1);

% Loop for ach value of the mesh
for j = 0:1:range
  p = j/range;
  I = eye(4);
  rho = (1-p)/4*I + p*max_rho;
  % Geometric measure
  [E, W] = GeometricMeasure(rho);
  geom(1,j+1) = E;
  geom_w(1,j+1) = trace(W*rho);
  [N, ~] = Negativity(rho);
  neg(1,j+1) = N;
end

% Plot
geom(geom < 0.00001) = nan;
neg(neg < 0.00001) = nan;
x = linspace(0,1, 101);

figure
plot(x,geom,x,neg)
xlabel('p')
legend('Geom. measure','Negativity')

figure
plot(x,geom_w)
ylabel('Tr(Wp)')
xlabel('p')
legend('Based on fidelity')