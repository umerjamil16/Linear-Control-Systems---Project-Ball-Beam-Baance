%For motor
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
L1 = 2.75E-6;
b = 0;

T_V = Kt/(s*((J1*s+b)*(L1*s+Ra)+Kt^2)); % for motor

%(L)      length of the beam            1.0 m
%(J)      ball's moment of inertia      9.99e-6 kg.m^2
%(r)      ball position coordinate
% We used golf ball for our purpose
m = 0.04593;  % mass of ball
R = 0.0427;  %radius of ball
J = (2*m*R*R)/(5) % ball moment of inertia

g = -9.8;   
L = 40e-2;    %Length of beam
d = 0.03; %lever arm offset 
R_T = -m*g*d/L/(J/R^2+m)/s^2; %gives R(s)/theeta(s) % for beam ball system
P_ball= R_T;
%Design Parameters
% Ts = 3 sec
% OS = 0.08

OS = 0.08;
zeta = pi/sqrt(pi*pi + (-2.5257)^2);
Ts = 3;
omegan=4/(zeta*Ts);
 %{
%%Lead comp         ---- ROOT LOCUS
zo = 1E-3;
po = 2.65;
C_lead=tf([1 zo],[1 po]);
%Lag comp
%zp = 17.61;
%pp = 0.01;
%C_lag =tf([1 zp],[1 pp]);
%Lag compensator places the root in the RHP so dont need it
rlocus(C_lead*P_ball)
sgrid(0.70, 1.9) %% look here plz
axis([ -3 .5 -2 2])
%k = 1.414;
k = 50;
sys_cl=feedback(k*C_lead*P_ball,1);
t=0:0.01:5;
figure
step(sys_cl,t)
stepinfo(sys_cl)
%}
%
%% PID Controllrt
Kp = 7;
Kd = 15;
C = pid(Kp,0,Kd);
sys_cl=feedback(C*P_ball,1);
t=0:0.01:5;
step(sys_cl);
stepinfo(sys_cl);

%}

%{
%%%%%%%%%%%PID controller      -------   1
PD = (s+1.72);
PI = (s+0.1)/s
PID = (s+4.35)*(s+0.05)/s;
sys_cl=feedback(PD*P_ball,1);
figure
step(sys_cl)
figure
rlocus(PI*PD*R_T)
sgrid(0.70, 1.9)
axis([-5 5 -2 2])

%}



