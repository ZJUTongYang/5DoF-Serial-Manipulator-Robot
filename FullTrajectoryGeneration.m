%% Trajectory Generation
%Script for generating a trajectory from a loading bay to a via point to
%the jenga tower


%DH parameters of our robot
a2 = 20;
a3 = 20;
d1 = 20;
d5 = 4;
dE = 3;
gripLength = d5 + dE; %Length of the end effector, always pointing downwards

%Length from robot base to the centroid of the jenga tower base
D = 23;

%%
%Choose arbitrary time length to travel to via point
t0 = 0;
tf = 10;

%choose starting pose at an arbitrary loading bay
r = 23;
phi = 45;
loadingBay = [r*cosd(phi) r*cosd(phi) 0 phi];

%initial velocity is 0
initposition = [loadingBay(1:3)];
initvelocity = [0 0 0];

%Choose joint values for this location
q1 = -phi;
q2=0;
q3=0;
q4=0;
q5 = phi;

%Use FW Kinematics code to get initial rotation
[T, Xt, Yt, Zt,EE,x,y,z] = FWi(q1, q2,q3, q4, q5,d1,a2,a3,d5,dE);
TT = T{1}*T{2}*T{3}*T{4}*EE{1}*EE{2};
Rinit = TT(1:3,1:3)

%Select via point:
%A high point directly above the loading bay but still within workspace and
%with same End Effector orientation
height = 36;
via = [loadingBay(1:2) loadingBay(3)+height phi]
finalposition=via

%Get rotation at via point by using inverse kinematics and then forward
%kinematics
[ q1, q2, q3, q4, q5 ] = IK(via(1),via(2),via(3),a2,a3,d1,d5,dE);
[T, Xt, Yt, Zt,EE,x,y,z] = FWi(q1, q2,q3, q4, q5,d1,a2,a3,d5,dE);
TT = T{1}*T{2}*T{3}*T{4}*EE{1}*EE{2};
Rfinal = TT(1:3,1:3)

%Choose velocity at via point as 0
finalvelocity=[0 0 0];

%Calculate Trajectory
[ PosRef, OrientRef,A] = generateTrajectory( initposition, initvelocity, Rinit, finalposition, finalvelocity, Rfinal, TT)
%posref and orientref are function handles for position and orientation
%reference trajectories respectively - displacement followed by velocity

%%
%Select final point on jenga tower:
%Choose the centroid of the base (assume no jenga tower layers have been constructed yet)
endpoint = [D 0 0 0];

%Choose arbitrary time length to travel to end point
t0 = 0;
tf = 10;


%initial position and velocity is the previous
initposition = [loadingBay(1:3)];
initvelocity = [0 0 0];

%initial orientation is the previous
Rinit = Rfinal;

%Choose final position
finalposition = endpoint;

%Get rotation at end point by using inverse kinematics and then forward
%kinematics
[ q1, q2, q3, q4, q5 ] = IK(endpoint(1),endpoint(2),endpoint(3),a2,a3,d1,d5,dE);
[T, Xt, Yt, Zt,EE,x,y,z] = FWi(q1, q2,q3, q4, q5,d1,a2,a3,d5,dE);
TT = T{1}*T{2}*T{3}*T{4}*EE{1}*EE{2};
Rfinal = TT(1:3,1:3);

%Choose velocity at via point as 0
finalVelocity=[0 0 0];

%Calculate Trajectory
[ PosRef, OrientRef, AA] = generateTrajectory( initposition, initvelocity, Rinit, finalposition, finalvelocity, Rfinal, TT)
%posref and orientref are function handles for position and orientation
%reference trajectories respectively
%%
% trajectoryTest