%% Separable states
state = 1/sqrt(4)*[1; 1; 1; 1];
rho = state*ctranspose(state);
[N, ~] = Negativity(rho);
assert(check_equality(N,0));

%% Bell states
disp("Analytical results to be added...")
state = Bell(0);
rho = state*ctranspose(state);
[N, ~] = Negativity(rho);
assert(check_equality(N,1/2));

state = Bell(1);
rho = state*ctranspose(state);
[N, ~] = Negativity(rho);
assert(check_equality(N,1/2));

state = Bell(2);
rho = state*ctranspose(state);
[N, ~] = Negativity(rho);
assert(check_equality(N,1/2));

state = Bell(3);
rho = state*ctranspose(state);
[N, ~] = Negativity(rho);
assert(check_equality(N,1/2));

% Even though should return the same value, by the addition of the third
% subsystem it is not able to solve it
state = kron(Bell(0),[1;0]);
rho = state*ctranspose(state);
[N, ~] = Negativity(rho);
assert(check_equality(N,0));

%% Tripartite states
% W (num qubits)
w = WState(3);
rho = w*ctranspose(w);
[N, ~] = Negativity(rho);
if(~check_equality(N,sqrt(2)/3))
    X = ['Equality not reached for W state: ',num2str(N-sqrt(2)/3),' off'];
    disp(X)
end

% GHZ (local dimensions, num subsystems)
ghz = GHZState(2,3);
rho = ghz*ctranspose(ghz);
[N, ~] = Negativity(rho);
assert(check_equality(N,1/2));

% GHZ (local dimensions, num subsystems)
ghz = GHZState(2,4);
rho = ghz*ctranspose(ghz);
[N, ~] = Negativity(rho);
assert(check_equality(N,1/2));

%% Multipartite
% Dicke (qubits, number of excitations)
d24 = DickeState(4,2);
rho = d24*ctranspose(d24);
[N, W] = Negativity(rho);
assert(check_equality(N,1/2));

%% Print end
disp("Tested ended successfully!")