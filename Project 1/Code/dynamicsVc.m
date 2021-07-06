function dstate = dynamicsVc(t,state,rc,lc)
%state 1 is Vc and state 3 is Vr

dstate(1)=state(2);
dstate(2)=-(1/rc)*state(2)-(1/lc)*state(1)+1/lc+2*cos(t);
dstate(3)=state(4);
dstate(4)=-1/rc*state(4)-1/lc*state(3)+1/lc*2*sin(t)-2*sin(t);

%output for ode function
dstate=dstate';

end
