function fMatrix1= matrixGenerator2Test(states,t)

L1=tf([-1 0],[1 140 4900]);
L2=tf([-1],[1 140 4900]);

L3=tf([1 0],[1 140 4900]);
L4=tf([1],[1 140 4900]);

u1=2*sin(t);
u2=zeros(length(t),1);
u2=u2+1;

f1=lsim(L1,states(:,1),t);
f2=lsim(L2,states(:,1),t);
f3=lsim(L3,u1,t);
f4=lsim(L4,u1,t);

f5=lsim(L3,u2,t);
f6=lsim(L4,u2,t);


fMatrix1=[f1 f2 f3 f4 f5 f6];

end

