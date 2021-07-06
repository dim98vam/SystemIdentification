clc;
clear;

a=2;
b=1;

tspan=[0 20];
state0=[0 0 0 0 0];
f=@(t,state)dynamics(t,state,a,b,5,50);

options=odeset('RelTol',10^-10,'AbsTol',10^-11);

[t,state]=ode15s(f,tspan,state0,options);

%create x_hat states
theta1_hat=(5-state(:,4));
x_hat=theta1_hat.*state(:,2)+state(:,5).*state(:,3);




figure(1)
plot(t,state(:,4),t,state(:,5))
legend('theta1Estimated','theta2Estimated')

figure(2)
plot(t,state(:,4)-2,t,state(:,5)-1)
legend('theta1Error','theta2Error')

figure(3)
plot(t,state(:,2).^2)
legend('phi_1 squared')

figure(4)
plot(t,state(:,1),t,x_hat)
legend('trueOutput','estimatedOutput')


figure(5)
plot(t,state(:,3).^2)
legend('phi_2 squared')

figure(6)
plot(t,state(:,2).*state(:,3))
legend('product of phi elements')

figure(7)
plot(t,state(:,1)-x_hat)
legend('OutputError')