%%For motor
s = tf('s');

W_noload = 3900*(2*pi/60); %rad/s
T_stall = 10.8e-3; %Nm
I_stall = 0.22; %Amps
e_a = 24; %DC operating voltage
kb = e_a/W_noload;
Kt = kb; % since we are using consistant units
Ra = Kt*e_a/T_stall;
m1 = 51e-3; %in kg
r1 = 30.8e-3; % radius of motor
J1 = .5*m1*r1*r1;
L1 = 0;%2.75E-6;
b = 0;  %assumption -- ideal conditions
P_motor = Kt/(s*((J1*s+b)*(L1*s+Ra)+Kt^2)); % for motor theeta/Ea(s)

OS = 0.08;
zeta = pi/sqrt(pi*pi + (-2.5257)^2);
Ts = 3;
omegan=4/(zeta*Ts);

%{
%% PID - root locus
C = (s+13456)*(s+0.5)/s
rlocus(C*P_motor)
sgrid(0.80, 166.6)
k = 6000.027;
sys_cl=feedback(k*C*P_motor,1);

t=0:0.01:5;
figure
step(sys_cl,t)
%}

%%% PID - controller
Kp = 10;
Kd = 5;
Ki = 3;
C = pid(Kp,Ki,Kd);

sys_cl=feedback(C*P_motor,1);

t=0:0.01:5;
step(sys_cl)
stepinfo(sys_cl)
