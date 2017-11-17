%%Establishing the workspace of the 2 arms in the Sagittal Plane of a 5DOF
%%serial manipulator

%% Clearing workspace
clc
clear all
close all
%% CONSTANTS
%Jenga Measurements
L = 7.5;
W = 2.5*3;
H = 1.5*(54/3);

%% Choosing Arm Parameters (by hardcoding)
% Required a2,a3,d1,d5,dE,theta1,theta2,theta3,theta4,theta5
d1 = 5; % d1 is the distance from bottom of the table to origin of joint 1
a2 = 28; % a2 is the length of parallelogram link
a3 = 18; % a3 is the link controlled by parallelogram
d5 = 4; % d5 is length of wrist
dE = 3; % dE is the distance between the last rotation axis to end effector

%% Plotting jenga tower
% Jenga position
syms q1 q2 q3 q4 q5 real;
q1 = 0;
q2 = -pi/2;
q3 = 0;
q4 = 0;
q5 = 0;

[T, Xt, Yt, Zt,EE,x,y,z] = FWi(q1, q2,q3, q4, q5, d1,a2,a3,d5,dE);

xyz = T{1}(1:3,4)
R0_1 = T{1}(1:3,1:3)
xyz = R0_1*xyz
plot3( [0 xyz(1)], [0 xyz(2)], [0 xyz(3)],'g');
hold on

%%
t = T{2};
XYZ = t(1:3,4)
R1_2 = T{2}(1:3,1:3)
XYZ = R0_1*R1_2*XYZ + xyz
plot3( [xyz(1) XYZ(1)], [xyz(2) XYZ(2)], [xyz(3) XYZ(3)],'r');

xyz=XYZ
%%
t = T{3};
XYZ = t(1:3,4)
R2_3 = T{3}(1:3,1:3)
XYZ = R0_1*R1_2*R2_3*XYZ + xyz
plot3( [xyz(1) XYZ(1)], [xyz(2) XYZ(2)], [xyz(3) XYZ(3)]);
xyz=XYZ
%%
t = T{4};
XYZ = t(1:3,4);
R3_4 = T{4}(1:3,1:3);
XYZ = R0_1*R1_2*R2_3*R3_4*XYZ + xyz
plot3( [xyz(1) XYZ(1)], [xyz(2) XYZ(2)], [xyz(3) XYZ(3)]);
xyz=XYZ

xlim([-10 60]);
ylim([-50 50]);
zlim([-10 60]);
xlabel('x')
ylabel('y')
zlabel('z')

plotJengaTower( 17, 0, 0, 17)
