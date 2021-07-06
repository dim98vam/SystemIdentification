clc;
clear;

a=2;
b=1;

tspan=[0 100];
state0=[0 5 7 5];
f=@(t,state)dynamics2_1(t,state,a,b,2);

options=odeset('RelTol',10^-10,'AbsTol',10^-11);

[t,state]=ode15s(f,tspan,state0,options);

figure(1)
plot(t,state(:,3),t,state(:,4))
legend('theta1EstimateCombined','theta2EstimateCombined')

figure(2)
plot(t,state(:,1)-state(:,2))
legend('outputErrorCombined')

g=@(t1,state1)dynamics2_2(t1,state1,a,b);
[t1,state1]=ode15s(g,tspan,state0,options);

figure(3)
plot(t1,state1(:,3),t1,state1(:,4))
legend('theta1EstimateParallel','theta2EstimateParallel')

figure(4)
plot(t1,state1(:,1)-state1(:,2))
legend('outputErrorParallel')