function dstate=dynamics2_2(t,state,a,b)

u=5*sin(3*t);

dstate(1)=-a*state(1)+b*u;
noise=state(1)+0.15*sin(2*pi*100*t);

dstate(2)=-state(3)*state(2)+state(4)*u;
dstate(3)=-state(2)*(noise-state(2));
dstate(4)=u*(noise-state(2));


dstate=dstate';
end

