%% Script for simulation of 5axis DOF robot

%% Constants
%DH parameters of our robot
a2 = 20;
a3 = 20;
d1 = 20;
d5 = 4;
dE = 3;
gripLength = d5 + dE; %Length of the end effector, always pointing downwards

%Length from robot base to the centroid of the jenga tower base
D = 23;

%% Forward Kinematics

syms q1 q2 q3 q4 q5 real;
%To get symbolic rotation matrices
[T, Xt, Yt, Zt,EE,x,y,z] = FWi(q1, q2,q3, q4, q5,d1,a2,a3,d5,dE)

%Symbolic transformation matrics, for reference
T = {T{1} T{2} T{3} T{4} EE{1} EE{2}};
%% Initialization
%Robot is at Loading Bay
q1 = -phi;
q2=0;
q3=0;
q4=0;
q5 = phi;

%% Jenga Tower
jengaHome = [D 0 0];
[ centre, Faces ] = plotJengaTower( jengaHome(1), jengaHome(2), angle, false);
hold on,
%% Loading Bay
yaw = 45;
angle = 0;
loadingBay = [D*cosd(yaw) D*cosd(yaw) 0];
[ centre, Faces ] = plotJengaBlock( loadingBay(1), loadingBay(2), angle, false);

%% Select via point:
%A high point directly above the loading bay but still within workspace and
%with same End Effector orientation
height = 36;
viapoint = [loadingBay(1:2) loadingBay(3)+height yaw];

%% Trajectory
syms t;

%initial position
initposition = [loadingBay(1:3)];

%initial velocity
initvelocity = [0 0 0];

%initial rotation
[TT, Xt, Yt, Zt,EE,x,y,z] = FWi(q1, q2,q3, q4, q5,d1,a2,a3,d5,dE)
TT = TT{1}*TT{2}*TT{3}*TT{4}*EE{1}*EE{2};
Rinit = TT(1:3,1:3);

%final position
finalposition=viapoint;

%final velocity
finalvelocity=[0 0 0];

%final rotation
%Get rotation at via point by using inverse kinematics and then forward
%kinematics
[ q1, q2, q3, q4, q5 ] = IK(viapoint(1),viapoint(2),viapoint(3),a2,a3,d1,d5,dE);
[T, Xt, Yt, Zt,EE,x,y,z] = FWi(q1, q2,q3, q4, q5,d1,a2,a3,d5,dE);
TT = T{1}*T{2}*T{3}*T{4}*EE{1}*EE{2};
Rfinal = TT(1:3,1:3);

%Calculate Trajectory
[ PosRef, OrientRef, A] = generateTrajectory( initposition, initvelocity, Rinit, finalposition, finalvelocity, Rfinal, t);
%posref and orientref are function handles for position and orientation
%reference trajectories respectively - displacement followed by velocity
