function dstates = odeDynamicsGrad(t,states,tspan,output,input,timestep,A,B,C,D,n,m,size1,size2,thetaBoundary,gamma,sigma)

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
phi=C*states(1:size1+size2)+ [D(1:n)*y;D(n+1:n+m)*u]; %actual phi inputs


%---use phi in conjuction with theta states to calculate estimeted output--
%--------------------------------------------------------------------------
error=y-states(size1+size2+1:end)'*phi;%error of current estimated system

 %incorporate usual continuous sigma algorithm for every element from m+n+1
 %to 2(m+n) in states vector
 for j=1:(m+n)
      temp=abs(states(size1+size2+j));
      if temp<thetaBoundary %normal gradient method
          dtheta(j)=gamma*error*phi(j);
      elseif temp>thetaBoundary && temp<2*thetaBoundary %sigma gradient method
          dtheta(j)=-sigma*(temp/thetaBoundary-1)*gamma*states(size1+size2+j)+gamma*error*phi(j);
      else
          dtheta(j)=-sigma*gamma*states(size1+size2+j)+gamma*error*phi(j);
      end
 end
 
 
%----------pass the d variables in the output as a column vector-----------
%--------------------------------------------------------------------------
dstates=[dx;dtheta'];

end

