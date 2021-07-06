%producing estimates and estimated system output with or without outliers
%outlier addition should be commented out if not needed

clc;
clear;

tspan=0:0.000001:5;
vTotal=zeros(length(tspan),2);

for i=1:length(tspan)
  temp=v(tspan(i));
  vTotal(i,1)=temp(1);
  vTotal(i,2)=temp(2);
end


%{
 %adding randomly 4 outliers
 r = randi([1 length(tspan)],1,4);
 for i=1:length(r)
   tmp=r(i);
   vTotal(tmp,1)=3;
   vTotal(tmp,2)=3;
 end
%}



[fTable,fTable2]=matrixGenerator2(vTotal,tspan');

A=(fTable')*fTable;
B=(fTable')*vTotal(:,1);
phi=linsolve(A,B);

rc=1/(phi(1)+13)
lc=1/phi(4)
theta1=phi(1)
theta2=phi(2)
theta3=phi(3)
theta4=phi(4)

%phi_2 for Vr
phi_2=phi;
phi_2(3)=1;


Vc_hat=fTable*phi;
Vr_hat=fTable2*phi_2;



figure(1)
plot(tspan,Vc_hat,tspan,Vr_hat)
legend('VcEstimated','VrEstimated')

figure(2)
plot(tspan,vTotal(:,1),tspan,vTotal(:,2))
legend('VcTrue','VrTrue')

figure(3)
plot(tspan,vTotal(:,1)-Vc_hat)
legend('VcError')

figure(4)
plot(tspan,vTotal(:,2)-Vr_hat)
legend('VrError')
