range = 100;
geom = zeros(1,range+1);
neg = zeros(1,range+1);

geom_w = zeros(1,range+1);
neg_w = zeros(1,range+1);

% Loop for ach value of the mesh
wnot = WNotState(3)*ctranspose(WNotState(3));
w = WState(3)*ctranspose(WState(3));
for j = 0:1:range
  p = j/range;
  rho = (1-p)*w + p*wnot;
  % Geometric measure
  [E, W] = GeometricMeasure(rho);
  geom(1,j+1) = E;
  geom_w(1,j+1) = trace(W*rho);
  [N, W] = Negativity(rho);
  neg(1,j+1) = N;
  neg_w(1,j+1) = trace(W*rho);
end

% Plot
geom(geom < 0.0001) = nan;
neg(neg < 0.0001) = nan;
x = linspace(0,1, 101);

figure
plot(x,geom,x,neg)
xlabel('p')
legend('Geom. measure','Negativity')

figure
plot(x,geom_w,x,neg_w)
xlabel('p')
ylabel('Tr(Wp)')
legend('Geom. measure','Negativity')