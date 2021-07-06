function result = LSOffline(n,m,pole,timestep,time)

%use offline least square algorithm to estimate system model
%user defines output and input derivative degree(n,m) as well 
%as filter pole - thetas defined by solving the linear system

m=m+1; % accomodate for zero degree of derivative 

%-----------------------system output creation-----------------------------
tspan=0:timestep:time;
u=0.1*cos(2*tspan)+sin(tspan)+0.1*cos(3*tspan)-0.1*cos(4*tspan)+...
    0.2*cos(5*tspan)-0.1*cos(6*tspan)+sin(7*tspan); % system input

y=out(tspan,u); %system output


%------------------------creating the phi vectors for----------------------
%-------------------------y and u o flinearized form-----------------------
temp=zeros(1,n);
temp(1,:)=pole;
denominator=poly(temp); %denominator of tfs

%y phi vectors
phiy=lsim(tf(num2cell(-eye(n),2),denominator),y,tspan);

%u phi vectors
phiu=lsim(tf(num2cell(eye(m),2),denominator),u,tspan);

phi=[phiy,phiu]; %complete phi vector

%------------------------calculate theta estimates-------------------------
A=(phi')*phi;
B=(phi')*y;
theta=linsolve(A,B); % theta estimate

%----------------------------------create output to evaluate ---------------------------
%---------------------------------------------------------------------------------------
u=cos(13*tspan)+cos(14*tspan)+cos(15*tspan)+sin(16*tspan)+sin(17*tspan);
tfdenominator=([0;theta(1:n)]'+denominator); %denominator of system's tf
tfnumerator=theta(n+1:end)'; %numerator of system's tf
yEstimated=lsim(tf(tfnumerator,tfdenominator),u,tspan); %output of estimated system

y=out(tspan,u); %system true output

%------------------------------------plotting both error types---------------------------
%----------------------------------------------------------------------------------------

offset=zeros(n+m,1);
offset(1:n)=denominator(2:end); %create offset to plot coefficients of diff equation and not thetas

figure(1)
subplot(1,2,1)
plot(tspan,yEstimated,tspan,y)
legend('Estimated Output','True Output')

subplot(1,2,2)
plot(tspan,y-yEstimated)
legend('Error of estimation y-y_h_a_t')


sgtitle(sprintf('Results for model with n=%d, m=%d.\n',n,m-1))

result=theta+offset;
end

