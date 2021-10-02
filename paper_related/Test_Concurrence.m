warning('off')

%% Separable states
state = 1/sqrt(4)*[1; 1; 1; 1];
C = Concurrence(state);
assert(check_equality(C, 0));

state = [1; 0; 0; 0];
C = Concurrence(state);
assert(check_equality(C, 0));

%% Bell states
state = Bell(0);
C = Concurrence(state);
assert(check_equality(C, 1));

state = Bell(1);
C = Concurrence(state);
assert(check_equality(C, 1));

state = Bell(2);
C = Concurrence(state);
assert(check_equality(C, 1));

state = Bell(3);
C = Concurrence(state);
assert(check_equality(C, 1));

%% Print end
disp("Tested ended successfully!")