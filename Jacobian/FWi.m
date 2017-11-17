function [T, Xt, Yt, Zt,EE,x,y,z] = FWi(q1, q2,q3, q4, q5,d1,a2,a3,d5,dE)
Xt=0;
Yt=0;
Zt=0;
x = 0;
y= 0;
z= 0;
%frame 0 is the inertial frame
%frame 1 is the joint at link 1 intersecting with the base
%frame 2 is the joint at the intersection of link 1 and 2
%frame 3 is at the end effector

T = cell(1,4);
EE = cell(1,2);
%% Atomic Matrices

%frame 0 - to joint 1
%R0_1 = [cos(q1) -sin(q1) 0;sin(q1) cos(q1) 0;0 0 1];
R0_1 = [cos(q1) -sin(q1) 0;sin(q1) cos(q1) 0;0 0 1];
r0_01 = [0 0 d1]';
T0_1 = [R0_1 r0_01; 0 0 0 1];
T{1} = T0_1;

%frame 1 - to joint 2
%R1_2 = [1 0 0; 0 cosd(-pi/2) -sind(-pi/2); 0 sind(-pi/2) cosd(-pi/2)]*[cos(q2-pi/2) -sin(q2-pi/2) 0; sin(q2-pi/2) cos(q2-pi/2) 0;0 0 1];
R1_2 = [1 0 0; 0 0 1; 0 -1 0]*[sin(q2) cos(q2) 0; -cos(q2) sin(q2) 0;0 0 1];
r1_12 = [0 0 0]';
T1_2 = [R1_2 r1_12; 0 0 0 1];
T{2} = T1_2;

%frame 2 - to joint 3
%R2_3 = [cos(q3+pi/2) -sin(q3+pi/2) 0; sin(q3+pi/2) cos(q3+pi/2) 0;0 0 1];
R2_3 = [-sin(q3) -cos(q3) 0; cos(q3) -sin(q3) 0;0 0 1];
r2_23 = [a2 0 0]';
T2_3 = [R2_3 r2_23; 0 0 0 1];
T{3} = T2_3;

%frame 3 - to joint 4
%R3_4 = [cos(q4) -sin(q4) 0; sin(q4) cos(q4) 0;0 0 1];
R3_4 = [cos(q4) -sin(q4) 0; sin(q4) cos(q4) 0;0 0 1];
r3_34 = [a3 0 0]';
T3_4 = [R3_4 r3_34; 0 0 0 1];
T{4} = T3_4;

%frame 4 - to joint 5
%R4_5 = [1 0 0; 0 cos(90) -sin(90); 0 sin(90) cos(90)]*[cos(q5) -sin(q5) 0; sin(q5) cos(q5) 0; 0 0 1];
R4_5 = [1 0 0; 0 0 -1; 0 1 0]*[cos(q5) -sin(q5) 0; sin(q5) cos(q5) 0; 0 0 1];
r4_45 = [0 d5 0]';
T4_5 = [R4_5 r4_45; 0 0 0 1];
EE{1} = T4_5;

%frame 5 - to End Effector
%R5_E = [1 0 0; 0 cos(180) -sin(180); 0 sin(180) cos(180)];
R5_E = [1 0 0; 0 -1 0; 0 0 -1];
r5_5E = [0 0 -dE]';
T5_E = [R5_E r5_5E; 0 0 0 1];
EE{2} = T5_E;

%% Assume there is a frame w instead of frame 5. 
% Origin of w occurs at the origin of frame 5, but is rotated to align with the EE frame
% Also assume that the origin is at the wrist, ie collocated with 4
% ie: d5 = 0

%frame 4 - to w
R4_w = R4_5*R5_E;
r4_4w = [0 -d5 0]';
T4_w = [R4_w r4_4w; 0 0 0 1];
T{5} = T4_w;

%%
%Return a cell matrix of all atomic T matrices
T;

% T0_3 = T0_1*T1_2*T2_3;
% 
% Xt = T0_3(1,4);
% Yt = T0_3(2,4);
% Zt = T0_3(3,4);



% R3 = R0_1*r1_12 + R0_1*R1_2*r2_23;
% Xt = R3(1);
% Yt = R3(2);
% Zt = R3(3);

% T0_2 = T0_1*T1_2;
% x = T0_2(1,4);
% y = T0_2(2,4);
% z = T0_2(3,4);

% R2 = R0_1*r1_12;
% x = R2(1);
% y = R2(2);
% z = R2(3);

end