function d_states = dynamicsMatrices(t,states,A,B)

u=5*sin(7.5*t)+10*sin(2*t);

%equations concerning true and estimated states
x_dot=A*[states(1);states(2)]+B*u;

A_hat=[states(5), states(6);states(7), states(8)];
B_hat=[states(9);states(10)];
x_hat_dot=A_hat*[states(3);states(4)]+B_hat*u;


%differential equations for theta estimates 
error1=(states(1)-states(3));
error2=(states(2)-states(4));

%A matrix differential equations
d_a11=states(3)*error1;
d_a12=states(4)*error1;
d_a21=states(3)*error2;
d_a22=states(4)*error2;

d_a=[d_a11;d_a12;d_a21;d_a22];

%B matrix diffrential equations
d_b11=u*error1;
d_b21=u*error2;

d_b=[d_b11;d_b21];


d_states=[x_dot;x_hat_dot;d_a;d_b];

end

