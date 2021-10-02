% Li et. al. 2017: Example 2
range = 50;

% Initialization
[X,Y] = meshgrid(0:1/range:1.0);
geom = zeros(range+1,range+1);
neg = zeros(range+1,range+1);

% Loop for ach value of the mesh
ghz = GHZState(2,3)*ctranspose(GHZState(2,3));
w = WState(3)*ctranspose(WState(3));
I = eye(8);
for i = 0:1:range
  for j = 0:1:(range-i)
      x = i/range;
      y = j/range;
      rho = (1-x-y)/8*I + x*ghz + y*w;
      % Geometric measure
      [E, Wg] = GeometricMeasure(rho);
      geom(i+1,j+1) = E;
      [N, Wn] = Negativity(rho);
      neg(i+1,j+1) = N;
  end
end

% Plot
geom(geom < 0.00001) = nan;
mesh(X,Y,geom, 'FaceColor', 'texturemap')
xlabel('x (GHZ)')
ylabel('y (W)')
zlabel('Eg')

figure
neg(neg < 0.00001) = nan;
mesh(X,Y,real(neg), 'FaceColor', 'texturemap')
xlabel('x (GHZ)')
ylabel('y (W)')
zlabel('N')