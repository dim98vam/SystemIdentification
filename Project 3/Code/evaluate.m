function yEstimated = evaluate(theta,n,m,pole,u,y,t)

%function used in evaluating estimated system - given the degree
%of the system to be evaluated as well as the theta estimation it 
%produces the estimated output for the time values in t vector
%using u, y and lsim function
%----------------------------------------------------------------

%--------------------create tfs and filter outputs---------------
%----------------------------------------------------------------
temp1=zeros(1,n);
temp1(1,:)=pole;
denominator=poly(temp1);%create denominator of tfs - common

phi=zeros(m+n,length(t));%preallocate phi for speed

temp2=-eye(n);
for i=1:n %y tfs and outputs
   phi(i,1:length(t))=lsim(tf(temp2(i,:),denominator),y,t); 
end

temp2=eye(m);
for i=(n+1):(n+m) %u tfs and outputs
   phi(i,1:length(t))=lsim(tf(temp2(i-n,:),denominator),u,t); 
end


yEstimated=theta*phi;%return output estimated

end

