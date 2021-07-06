function result = LSOde(n,m,beta,pole,time,timestep)

%incorporate linearized form and ode45 with interpolation to estimate linear system
%coefficients - degree of output derivative, input derivative
%------------------------------------------------------------------------------------------

m=m+1; %accounts for difference between verbal and written number of coefficients

%-----------------------------create y and u transfer functions-------------------------
%---------------------------------------------------------------------------------------
temp=zeros(1,n);
temp(1,:)=pole;
denominator=poly(temp);
[A,B,C,D]=tf2ss(-eye(n),denominator);%transfer functions of y filters in state equations

[a,b,c,d]=tf2ss(eye(m),denominator);%transfer functions of y filters in state equations

%create block matrices to be provided to ode - D matrix not needed because
%system is strictly proper
size1=size(A,1);
size2=size(a,1);

A=[A,zeros(size(A,1),size(a,1));zeros(size(a,1),size(A,1)),a];
B=[B;b];
C=[C,zeros(n,size(c,2));zeros(m,size(C,2)),c];

%-----------generate input/output vectors to be used in ode identification phase--------
%---------------------------------------------------------------------------------------
tspan=0:timestep:time;
u=0.1*cos(2*tspan)+sin(tspan)+0.1*cos(3*tspan)-0.1*cos(4*tspan)+0.2*cos(5*tspan)-0.1*cos(6*tspan)+sin(7*tspan); % system input
y=out(tspan,u); %system output

%--------------------------------------------call ode-----------------------------------
%---------------------------------------------------------------------------------------
options=odeset('RelTol',10^-8,'AbsTol',10^-9);
Q0=eye(m+n,m+n);
state0=zeros(1,n+m+size1+size2+(m+n)^2);
state0(n+m+size1+size2+1:end)=Q0(:);
f=@(t,states)odeDynamicsLS(t,states,tspan,y,u,timestep,A,B,C,n,m,size1,size2,beta);

[t,state]=ode45(f,tspan,state0,options);

%---------------------------------create error unobtainable through ode-----------------
%---------------------------------------------------------------------------------------

error=errorProduce(C,state,size1+size2,y,m,n);


%----------------------------------create output to evaluate ---------------------------
%---------------------------------------------------------------------------------------
u=cos(13*tspan)+cos(14*tspan)+cos(15*tspan)+sin(16*tspan)+sin(17*tspan);
output=out(tspan,u); 
yestimated=evaluate(state(length(tspan),size1+size2+1:size1+size2+m+n),n,m,pole,u,output,tspan);


%------------------------------------plotting theta and both error types---------------------------
%--------------------------------------------------------------------------------------------------
offset=zeros(n+m,1);
offset(1:n)=denominator(2:end); %create offset to plot coefficients of diff equation and not thetas

figure(1)

subplot(2,2,1)
plot(t,state(:,size1+size2+1)+offset(1))

hold on;
for i=2:n+m
   plot(t,state(:,size1+size2+i)+offset(i))
end
hold off;

legend(arrayfun(@(mode) sprintf('coefficient %d', mode), 1:n+m, 'UniformOutput', false))

subplot(2,2,2)
plot(tspan,output(:)-yestimated(:))
legend('observation error')

subplot(2,2,3)
plot(t,error)
legend('training error')

subplot(2,2,4)
plot(tspan,output,tspan,yestimated);
legend('true output','estimated output')

sgtitle(sprintf('Results for model with n=%d, m=%d.',n,m-1))

result=size(state,1);


end

