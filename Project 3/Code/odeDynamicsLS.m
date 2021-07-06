function dstates = odeDynamicsLS(t,states,tspan,output,input,timestep,A,B,C,n,m,size1,size2,beta)

%A,B,C,D are the matrices describing the filters at the input 
%of the linearized system - are combined matrices of systems describing
%u and y tfs respectively

%--------linear interpolation used to calculate input at specific time-----
%------------------------------ode execution-------------------------------
y=linearInter(tspan,output,t,timestep);%output at current run of ode via interp
u=linearInter(tspan,input,t,timestep); %system input at current run of ode via interp 


%------------------equations for states describing phi inputs - found------
%--------------------------------first n+m states--------------------------
dx=A*states(1:size1+size2) + [B(1:size1)*y;B(size1+1:size1+size2)*u]; %derivative of inputs
phi=C*states(1:size1+size2); %actual phi inputs - D matrix not used since since is strictly proper


%---use phi in conjuction with theta states to calculate estimeted output--
%--------------------------------------------------------------------------
error=y-states(size1+size2+1:size1+size2+m+n)'*phi;%error of current estimated system


%---------------------create P table to use in method ---------------------
%--------------------------------------------------------------------------
index=size1+size2+m+n+1; %index used in states vector to dereference P elements

P=zeros(m+n,m+n); %preallocate P table

for i=0:(m+n-1)
    tmp=index+i*(m+n);
    P(i+1,:)=states(tmp:tmp+m+n-1);
end

dtheta=P*error*phi; %calculate dtheta
dP=beta*P-P*(phi)*(phi')*P; %calculate

dstates=zeros(m+n+size1+size2+(m+n)^2,1);
dstates(1:size1+size2)=dx; %assign dx to dstates

temp=size1+size2+1;
dstates(temp:temp+m+n-1)=dtheta; %assign dtheta to dstates

for i=0:(m+n-1) %assign dP elements to dstates
    tp=index+i*(m+n);
    dstates(tp:tp+m+n-1)=dP(i+1,:);
end


end

