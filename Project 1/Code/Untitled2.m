clc;
clear;

tspan=0:0.000001:5;
vTotal=zeros(length(tspan),2);

for i=1:length(tspan)
  temp=v(tspan(i));
  vTotal(i,1)=temp(1);
  vTotal(i,2)=temp(2);
end
fTable=matrixGenerator2Test(vTotal,tspan');

A=(fTable')*fTable;
B=(fTable')*vTotal(:,1);
phi=linsolve(A,B);




Vc_hat=fTable*phi;



figure(1)
plot(tspan,Vc_hat)
legend('VcEstimated')

figure(2)
plot(tspan,vTotal(:,1))
legend('VcTrue')

figure(3)
plot(tspan,vTotal(:,1)-Vc_hat)
legend('VcError')

