function result = errorProduce(C,states,size,y,m,n)

%function created to produce the error not obtainable from ode

lgth=length(y);
error=zeros(1,lgth); %preallocate for speed

for i=1:lgth
    phi=C*states(i,1:size)'; %D not needed because systems examined are strictly proper
    error(i)=y(i)-states(i,size+1:size+m+n)*phi;
end

result=error;
end

