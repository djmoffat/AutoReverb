clear;

syms decay diffus

t60 = 100;
a =       942.4;
b =   2.004e-05;
c =       20.54;
d =   1.617e+04;
e =      -6.446;
eqn = [decay == log((a + d*exp(e * diffus) - t60)/b)/c;...
        diffus == log((a + b*exp(c * decay)- t60)/d) / e];
solveD = solve(eqn)
    % solveD = solve(eqn,'IgnoreAnalyticConstraints',true)

solveD.decay

solveD.diffus

%%

RT60 = 1.45;
diffus = 0:0.01:1;
decay = 0:0.01:1;

X = a + b*exp(c * decay) + d*exp(e * diffus)
surf(X)

%%
a =       942.4;
b =   2.004e-05;
c =       20.54;
d =   1.617e+04;
e =      -6.446;

t60 = 2000;
ii = 0:0.001:1;
% for LOOP = 0:0.01:1
   
decay = abs(log((a + d*exp(e * ii) - t60)/b)/c);
diffus = abs(log((a + b*exp(c * ii)- t60)/d) / e);

plot(decay,diffus)


[v,idx] = min(abs(abs(decay) - abs(diffus)));
%%
plot(t60,decay)
plot(t60,diffus)
