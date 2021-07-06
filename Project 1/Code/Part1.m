clc;
clear;

b=0.2;
k=2;
m=15;

tspan=0:0.01:10;
state0=[0 0];

f=@(t,state)dynamics(t,state,b,k,m);

options=odeset('RelTol',10^-10,'AbsTol',10^-11);

[t,state]=ode15s(f,tspan,state0,options);

%solve linear system for phi variables
fTable=matrixGenerator1(t,state);
A=(fTable')*fTable;
B=(fTable')*state(:,1);
phi=linsolve(A,B);

theta=[(phi(1)+13)/phi(3);(phi(2)+42)/phi(3);1/phi(3)]

g=@(t,x)dynamics(t,x,theta(1),theta(2),theta(3));
[t,x]=ode15s(g,tspan,state0,options);

figure(1)
plot(t,state(:,1),t,x(:,1))
legend('yTrue','yEstimated')

figure(2)
plot(t,state(:,1)-x(:,1))
legend('error')



