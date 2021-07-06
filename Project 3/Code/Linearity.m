clc;
clear;

%-------------------------------------------------------------------------
%output generation with total output
timestep=0.0001; %change here---------------------------------------------
t=0:timestep:20; %time vector  
u=sin(t)+cos(2*t)+cos(3*t); %out system input
y=out(t,u); %y=system output vector

%output generation with partial inputs------------------------------------
%1st output/input combination
u1=sin(t);
y1=out(t,u1);

%2nd output/input combination
u2=cos(2*t);
y2=out(t,u2);

%3rd output/input combination
u3=cos(3*t);
y3=out(t,u3);

ycombined=y1+y2+y3;

figure(1)
plot(t,y1,t,y2,t,y3)
legend('sin(t) output','cos(2t) output','cos(3t) output')

figure(2)
plot(t,y,t,ycombined)
legend('initial output','combined output')

figure(3)
plot(t,y-ycombined)
legend('error between outputs')


%coefficient test
u4=4*cos(3*t);
y4=out(t,u4);

figure(4)
plot(t(1:20000),y4(1:20000)./y3(1:20000))
legend('magnitude increase of output')

%time invariance test
u4=sin(t+pi/2);
y4=out(t,u4);
figure(5)

plot(t,y1,t,y4)
legend('output for sin(t)','output for sin(t-pi/2)')

