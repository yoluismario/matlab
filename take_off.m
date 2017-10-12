clc
clear all

% take-off rotation analysis
m= 50000;% kg
S = 100; 
Sh=25; % m^2
g=9.81;
T = 2*60000; % N, Engine thrust
W_TO = m*g;
K = 0.4;
CDoTO = 0.04;%Take-of drag coef
mu = 0.04; % friction coef
theta_dd = 1.8/57.3;% rad/s^2 takeoff rotation pitch angular acceleration
CLc = 0.3;% cruise lift coef
d_CLf = 0.4; %cl adicional por flap
CL_alfa = 5.5; %1/rad horizontal tail lift curve slope
CL_ah = 4.5; % horizontal tail lift curve
CLho = -1.2; 
dt = 0.01;
t_tot =3.4;
iT = 5/57.3; %rad engine setting angle
rho = 1.225;
theta(1)=0; %pitch angle
d_theta(1) = 0;
x(1)=0;
V(1)= 120*0.514;% rotation speed
w(1)=0; %angular velocity (rad/seg)
time1(1) = 0;
alpha(1) = 0;
CLwf(1) = CLc +d_CLf; %wing fuselaje lift coef
CLh(1) = CLho; %initial horizontal tail lift coef
Lwf(1) = 0.5*rho*V(1)^2*S*CLwf(1);% wing-fuselaje lift
CD(1) = CDoTO+K*CLwf(1)^2;
D(1) = 0.5*rho*V(1)^2*S*CD(1);
Lh(1) = 0.5*rho*V(1)^2*Sh*CLh(1); % horizontal tail lift
N(1) = W_TO -Lh(1) -Lwf(1)-T*sin(iT+alpha(1)); %normal force to the ground
a(1) = (T*cos(iT+alpha(1))-D(1)-mu*N(1))/m; % linear acceleration
i=1;

for t = dt:dt:t_tot
  theta(i+1) = theta(i)+w(i)*dt+0.5*theta_dd*dt^2;
  w(i+1)=w(i)+theta_dd*dt;
  d_theta(i+1)=theta(i+1)-theta(i);
  alpha(i+1)=theta(i);
  x(i+1) =x(i)+V(i)*dt+0.5*a(i)*dt^2;
  dx = x(i+1)-x(i);
  V(i+1) = sqrt(V(i)^2+2*a(i)*dx);
  CLwf(i+1)=CLc+d_CLf+CL_alfa*alpha(i+1);
  CD(i+1)=CDoTO+K*CLwf(i+1)^2;
  Lwf(i+1)=0.5*rho*V(i+1)^2*S*CLwf(i+1);
  D(i+1)=0.5*rho*V(i+1)^2*S*CD(i+1);
  CLh(i+1)=CLho+CL_ah*alpha(i+1);
  Lh(i+1)=0.5*rho*V(i+1)^2*Sh*CLh(i+1);
  N(i+1)=W_TO-Lh(i+1)-Lwf(i+1)-T*sin(iT+alpha(i+1));
  a(i+1)=(T*cos(iT+alpha(i+1))-D(i+1)-mu*N(i+1))/m;
  time1(i+1)=t;
  i=i+1;
end

subplot(411)
%plot(time1,alpha*57.3,'rO-'); grid
 plot(time1,alpha,'r*'); grid on;
subplot(412)
 plot(time1,V,'b*');grid on;
subplot(413)
 plot(time1,N,'b*');grid on;
 