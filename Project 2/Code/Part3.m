clc;
clear;

tspan=[0 100];
state0=[0 0 0 0 0 0 0 0 0 0];

A=[-0.25, 3; -5, -1];
B=[1; 2.2];

f=@(t,state)dynamicsMatrices(t,state,A,B);
options=odeset('RelTol',10^-10,'AbsTol',10^-11);

[t,states]=ode15s(f,tspan,state0,options);

figure(1)
plot(t,states(:,5),t,states(:,6),t,states(:,7),t,states(:,8))
legend('a11Estimate','a12Estimate','a21Estimate','a22Estimate')

figure(2)
plot(t,states(:,9),t,states(:,10))
legend('b11Estimate','b21Estimate')

figure(3)
plot(t,states(:,1),t,states(:,3))
legend('x_1True','x_1Estimate')
figure(4)
plot(t,states(:,2),t,states(:,4))
legend('x_2True','x_2Estimate')