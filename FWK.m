function [X, Y, Z] = FWK(a2,a3,d1,d5,dE,theta1,theta2,theta3,theta4,theta5)

%frame 0 is the inertial frame
%frame 1 is the frame of the robot base
%frame 2 is the joint connecting robot base to parallelogram link
%frame 3 is the frame of link controlled by parallelogram
%frame 4 is the joint to rotate the gripper downward
%frame 5 is the frame which control direction of end effector

%% General form
% Dx_ai1 = [1 0 0 ai1;
%             0 1 0 0;
%             0 0 1 0;
%             0 0 0 1];
% Rx_ai1 = [ 1 0 0 0;
%             0 cosd(ai1) -sind(ai1) 0;
%             0 sind(ai1) cosd(a1i) 0;
%             0 0 0 1];
% Dz_di = [1 0 0 0;
%             0 1 0 0;
%             0 0 1 d1;
%             0 0 0 1];
% Rz_ti = [ cosd(ti) -sind(ti) 0 0;
%         sind(ti) cosd(ti) 0  0;
%         0 0 1 0;
%         0 0 0 1];
% Ti1_i = Dx_ai1*Rx_ai1*Dz_di*Rz_ti;

%% Transformation matrix
%frame 0 to 1
T0_1 = DH(0,0,d1,theta1);

%frame 1 to 2
T1_2 = DH(-90,0,0,theta2-90);

%frame 2 to 3
T2_3 = DH(0,a2,0,theta3+90);

%frame 3 to 4
T3_4 = DH(0,a3,0,theta4);

%frame 4 to 5
T4_5 = DH(90,0,-d5,theta5);

%frame 5 to E
T5_E = DH(180,0,dE,0);

%frame 0 to E
T0_E = T0_1*T1_2*T2_3*T3_4*T4_5*T5_E;

X = T0_E(1,4);
Y = T0_E(2,4);
Z = T0_E(3,4);

end