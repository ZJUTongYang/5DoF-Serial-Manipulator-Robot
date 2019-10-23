function [ q1, q2, q3, q4, q5 ] = IK(x,y,z,a2,a3,d1,d5,dE)


robotorigin = [0;0;0];

% a2 = 20%A(1)%20;
% a3 = 20%A(2)%20;
% d1 = 10%A(3)%20;
% d5 = 4;
% dE = 3;
% 
% x = a3;
% y = 0;
% z = d1+(a2-d5-dE)

%origin of {4}
x4 = x;
y4 = y;
z4 = z+d5+dE;

%origin of {2}
x2 = robotorigin(1);
y2 = robotorigin(2);
z2 = robotorigin(3)+d1;

%% q1 - sagittal plane eqn
q1 = atan2(y,x);
%% q5
q5 = 0;

%Length from 2 to 4
l24 = sqrt( (x4-x2)^2 +(y4-y2)^2+ (z4-z2)^2);

%Q3 always in quad 1 cause elbow down
q3 = asin( (l24^2 - a2^2 - a3^2)/(-2*a2*a3) );

beta = asin(a3*cos(q3)/l24);
%beta can be in quadrant 1 or 2
%Assume in quad 1
q2 = pi/2 - atan( (z4-z2)/sqrt((x4-x2)^2+(y4-y2)^2) ) - beta;
q4 = -q2-q3;

%If beta not in quad 1
[xg,yg,zg] = FWK(a2,a3,d1,d5,dE,q1,q2,q3,q4,q5);
if (abs(xg-x) > 0.01 || abs(yg-y) > 0.01 || abs(zg-z) > 0.01)
     %Wrong q2 value
     fprintf('Wrong q2\n');
     q2 = pi/2 - atan( (z4-z2)/sqrt((x4-x2)^2+(y4-y2)^2) ) - (pi-beta);
     q4 = -q2-q3;
end
%fprintf('Q3 is %f \n',rad2deg(q3));
%q2 must be in range of -90 and 80 deg




%% solving for q2 q3
% two = [x2; y2; z2; 1];
% four = [x4; y4; z4; 1];
% syms q2 q3
% 
% g = 90;
% h = q2-90;
% T1_2 = [cos(g) -sin(g) 0 0;sin(g) cos(g) 0 0;0 0 1 0; 0 0 0 1]*[cos(h) -sin(h) 0 0;sin(h) cos(h) 0 0;0 0 1 0; 0 0 0 1];

%frame 0 to 1
% T0_1 = DH(0,0,d1,q1);
% 
% %frame 1 to 2
% T1_2 = DH_syms(-90,0,0,q2-90);
% 
% h = q3+90;
% T2_3 = [cos(h) -sin(h) 0 a2;sin(h) cos(h) 0 0;0 0 1 0; 0 0 0 1];
% 
% h = -q2-q3;
% T3_4 = [cos(h) -sin(h) 0 a3;sin(h) cos(h) 0 0;0 0 1 0; 0 0 0 1];
% 
% T = T0_1*T1_2*T2_3*T3_4;
% 
% %expr = T*four;
% %eq1 = two(1) == expr(1);
% %eq2 = two(2) == expr(2);
% pretty(T(1,4))
% eq1 = T(1,4) == x4;
% eq2 = T(2,4) == y4;
% eq3 = T(3,4) == z4;
% %[a, b] = solve(eq1, eq2 ,q2,q3);
% [a, b] = solve(eq1, eq2 ,eq3, q2,q3);

% %% constraints
% q2const = pi/2;
% q3const = pi/2;
% % validating q2 q3
% q2 = double(q2);
% q3 = double(q3);
% 
% if abs(q2(1))>q2const
%     q2 = q2(2)
% else
%     q2 = q2(1);
% end
% 
% if abs(q3(1))>q3const
%     q3 = q3(2);
% else
%     q3 = q3(1);
% end
% 
% %% q4
% q4UB = 80;
% q4LB = -90;
% q4 = -q2-q3;
% if q4>0
%     q4 = min(q4,q4UB*2*pi/360);
% else
%     q4 = max(q4,q4LB*2*pi/360);
% end
%% converting to degrees
q1 = q1*180/pi;
q2 = q2*180/pi;
q3 = q3*180/pi;
q4 = q4*180/pi;
q5 = q5*180/pi;
end
