%% Separable states
state = 1/sqrt(4)*[1; 1; 1; 1];
rho = state*ctranspose(state);
[E, ~] = GeometricMeasure(rho);
assert(check_equality(E,0));

%% Bell states
disp("Analytical results to be added...")
state = Bell(0);
rho = state*ctranspose(state);
[E, ~] = GeometricMeasure(rho);
assert(check_equality(E,1/2));

state = Bell(1);
rho = state*ctranspose(state);
[E, ~] = GeometricMeasure(rho);
assert(check_equality(E,1/2));

state = Bell(2);
rho = state*ctranspose(state);
[E, ~] = GeometricMeasure(rho);
assert(check_equality(E,1/2));

state = Bell(3);
rho = state*ctranspose(state);
[E, ~] = GeometricMeasure(rho);
assert(check_equality(E,1/2));

% Shouldn't increase by the addition of a third separated system
state = kron(Bell(0),[1;0]);
rho = state*ctranspose(state);
[E, ~] = GeometricMeasure(rho);
assert(check_equality(E,1/2));

%% Tripartite states
% W (num qubits)
w = WState(3);
rho = w*ctranspose(w);
[E, ~] = GeometricMeasure(rho);
assert(check_equality(E,5/9));

% GHZ (local dimensions, num subsystems)
ghz = GHZState(2,3);
rho = ghz*ctranspose(ghz);
[E, ~] = GeometricMeasure(rho);
assert(check_equality(E,1/2));

% GHZ (local dimensions, num subsystems)
ghz = GHZState(2,4);
rho = ghz*ctranspose(ghz);
[E, ~] = GeometricMeasure(rho);
assert(check_equality(E,1/2));

% Adding noise
p = 0.83;
I = eye(2^3);
ghz = GHZState(2,3);
max_rho = ghz*ctranspose(ghz);
rho = (1-p)/(2^3)*I + p*max_rho;
[E, ~] = GeometricMeasure(rho);
assert(check_equality(E,0.2622));

%% Multipartite
% Dicke (qubits, number of excitations)
d24 = DickeState(4,2);
rho = d24*ctranspose(d24);
[E, W] = GeometricMeasure(rho);
assert(check_equality(E,5/8));

%% Print end
disp("Tested ended successfully!")