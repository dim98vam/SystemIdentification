function dstate=dynamics2_1(t,state,a,b,thetam)

u=5*sin(3*t);

dstate(1)=-a*state(1)+b*u;
noise=state(1)+0.15*sin(2*pi*100*t);

dstate(2)=-state(3)*noise+state(4)*u+thetam*(noise-state(2));
dstate(3)=-noise*(noise-state(2));
dstate(4)=u*(noise-state(2));


dstate=dstate';
end

