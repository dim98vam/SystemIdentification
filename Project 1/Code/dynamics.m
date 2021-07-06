function dstate = dynamics(t,state,b,k,m)


dstate(1)=state(2);
dstate(2)=-(k/m)*state(1)-(b/m)*state(2)+5*1/m*sin(2*t) + 10.5/m;
dstate=dstate';

end

