function [fMatrix1 fMatrix2] = matrixGenerator2(states,t)

L1=tf([-1 0],[1 140 4900]);
L2=tf([-1],[1 140 4900]);
L3_1=tf([1 0],[1 140 4900]);
L4_1=tf([1],[1 140 4900]);
L3_2=tf([1 0 0],[1 140 4900]);
L4_2=tf([1],[1 140 4900]);

u1=2*sin(t);
u2=zeros(length(t),1);
u2=u2+1;

f1=lsim(L1,states(:,1),t);
f2=lsim(L2,states(:,1),t);
f3_1=lsim(L3_1,u1+u2,t);
f4_1=lsim(L4_1,u2,t);

f1_2=lsim(L1,states(:,2),t);
f2_2=lsim(L2,states(:,2),t);
f3_2=lsim(L3_2,u1+u2,t);
f4_2=lsim(L4_2,u1,t);

fMatrix1=[f1 f2 f3_1 f4_1];
fMatrix2=[f1_2 f2_2 f3_2 f4_2];
end

