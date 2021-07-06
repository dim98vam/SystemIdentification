function dstate=dynamics(t,state,a,b,thetam,gamma)

dstate(1)=-a*state(1)+b*5*sin(3*t);
dstate(2)=-thetam*state(2)+state(1);
dstate(3)=-thetam*state(3)+5*sin(3*t);
dstate(4)=-gamma*(state(2)*state(1)-(thetam-state(4))*state(2)^2-state(5)*state(3)*state(2));
dstate(5)=-gamma*(-state(3)*state(1)+(thetam-state(4))*state(2)*state(3)+state(5)*state(3)^2);


dstate=dstate';
end

