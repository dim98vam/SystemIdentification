function result = linearInter(x,y,requestedX,timestep)
 %find the output at the requestedX using the linearInterpolation method
 %function created to avoid the delay caused by inbuild interp1
 
 if(mod(requestedX,1)==0) %do this to avoid floating point bug when requestedX
                          %matches interval boundaries
     result=y(requestedX+1);
 else   
  %find boundary values for the requested interval
  index=floor(requestedX/timestep)+1; %index of the bottom boundary
                                     %plus 1 caters for matlab indexing
 
  previousX=x(index); %boundary values
  nextX=x(index+1);
  previousY=y(index);
  nextY=y(index+1);
 
  %calculating output
  result=previousY+(nextY-previousY)/(nextX-previousX)*(requestedX-previousX);
 end
 
 end

