a2 = 20;
a3 = 20;
d1 = 10;
d5 = 4;
dE = 3;
theta1 = 0;
theta2 = 35.9857;
theta3 = 63.58;
theta4 = -theta2-theta3;;
theta5 = 0;

% Transformation matrix
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
figure;
hold on;
ylim([-20 60])
xlim([-20 60])
T0_2 = T0_1*T1_2;
T0_3 = T0_1*T1_2*T2_3;
T0_4 = T0_1*T1_2*T2_3*T3_4;
T0_5 = T0_1*T1_2*T2_3*T3_4*T4_5;
T0_E = T0_1*T1_2*T2_3*T3_4*T4_5*T5_E;
X = [0;
    T0_1(1,4);
    T0_2(1,4);
    T0_3(1,4);
    T0_4(1,4);
    T0_5(1,4);
    T0_E(1,4)];
Y = [0;
    T0_1(3,4);
    T0_2(3,4);
    T0_3(3,4);
    T0_4(3,4);
    T0_5(3,4);
    T0_E(3,4)];
plot(X,Y);