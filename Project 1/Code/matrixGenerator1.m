function [fTable] = matrixGenerator(t,state)
%calculate ? data for least square algorithm

%?(s)=(s+1)(s+2)->filter in time=exp(-t)-exp(-2*t)
%u1-u3 holding filter and derivatives in discrete time
u2=tf([-1],[1,13,42]);
u3=tf([1],[1,13,42]);
u1=tf([-1,0],[1,13,42]);



%variables holding input and sample vectors
input=5*sin(2*t)+10.5;
output=state(:,1);

%variables holding ? table values
f1=lsim(u1,output,t);
f2=lsim(u2,output,t);
f3=lsim(u3,input,t);

f=[f1,f2,f3];
fTable=f;


end

