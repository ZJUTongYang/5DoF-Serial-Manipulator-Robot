function [Xt, Yt, Zt,x,y,z] = FW(q1, q2,L1,L2)

%frame 0 is the inertial frame
%frame 1 is the joint at link 1 intersecting with the base
%frame 2 is the joint at the intersection of link 1 and 2
%frame 3 is at the end effector

%frame 0 - located at base
R0_1 = [1 0 0; 0 cos(q1) -sin(q1); 0 sin(q1) cos(q1)];
r0_01 = [0 0 0]';
T0_1 = [R0_1 r0_01; 0 0 0 1];

%frame 1 - attached to link 1
R1_2 = [1 0 0; 0 cos(q2) -sin(q2); 0 sin(q2) cos(q2)];
r1_12 = [0 0 L1]';
T1_2 = [R1_2 r1_12; 0 0 0 1];

%frame 2 - attached to link 2
R2_3 = [1 0 0; 0 0 1; 0 -1 0];
r2_23 = [0 L2 0]';
T2_3 = [R2_3 r2_23; 0 0 0 1];


T0_3 = T0_1*T1_2*T2_3;
Xt = T0_3(1,4);
Yt = T0_3(2,4);
Zt = T0_3(3,4);

% R3 = R0_1*r1_12 + R0_1*R1_2*r2_23;
% Xt = R3(1);
% Yt = R3(2);
% Zt = R3(3);

T0_2 = T0_1*T1_2;
x = T0_2(1,4);
y = T0_2(2,4);
z = T0_2(3,4);

% R2 = R0_1*r1_12;
% x = R2(1);
% y = R2(2);
% z = R2(3);

end