% Toth 2015
range = 80;

% Initialization
[X,Y] = meshgrid(0:1/range:1.0);
geom = zeros(range+1,range+1);
neg = zeros(range+1,range+1);

% Loop for ach value of the mesh
ghz_p = GHZState(2,3)*ctranspose(GHZState(2,3));
coefs = [1,-1]/sqrt(2);
ghz_n = GHZState(2,3,coefs)*ctranspose(GHZState(2,3,coefs));
w = WState(3)*ctranspose(WState(3));
for i = 0:1:range
  for j = 0:1:(range-i)
      x = i/range;
      y = j/range;
      rho = (1-x-y)*w + x*ghz_p + y*ghz_n;
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
xlabel('x (GHZ+)')
ylabel('y (GHZ-)')
zlabel('Eg')

figure
neg(neg < 0.00001) = nan;
mesh(X,Y,real(neg), 'FaceColor', 'texturemap')
xlabel('x (GHZ+)')
ylabel('y (GHZ-)')
zlabel('N')