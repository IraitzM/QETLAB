% State
Q = 3;
disp("W3 state") 
state = WState(Q);
[Gw3,Nw3] = EvalNoiseTolerance(state,Q);

disp("GHZ3 state") 
state = GHZState(2,Q);
[Gg3,Ng3] =EvalNoiseTolerance(state,Q);

Q = 4;
disp("W4 state") 
state = WState(Q);
[Gw4,Nw4] =EvalNoiseTolerance(state,Q);

disp("GHZ4 state") 
state = GHZState(2,Q);
[Gg4,Ng4] =EvalNoiseTolerance(state,Q);

disp("Dicke state") 
state = DickeState(Q,2);
[Gd4,Nd4] =EvalNoiseTolerance(state,Q);

% Plot
x = linspace(0,1, 1001);
figure
plot(x,fliplr(Gw3),x,fliplr(Nw3))
xlabel('p')
legend('Geom. measure','Negativity')
