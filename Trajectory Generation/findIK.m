%Jenga Measurements
L = 7.5;
W = 2.5*3;
H = 1.5*(54/3);

%DH Paramaters
a2 = 20;%A(1)%20;
a3 = 20;%A(2)%20;
d1 = 10;%A(3)%20;
d5 = 4;
dE = 3;
%robot, jenga placements
D = 17;
%Position of the 8 corners of the janga tower
halfblock = 7.5/2;
Corners = [ D               -halfblock      0;
            D               halfblock       0;
            D+halfblock     -halfblock      0;
            D+halfblock     halfblock       0;
            D               -halfblock      H;
            D               halfblock       H;
            D+halfblock     -halfblock      H;
            D+halfblock     halfblock       H];

%Solve for inverse kinematics        
Solution = ones(8,5);
FWSolution = ones(8,3);
for i= 1:1:8
    x = Corners(i,1);
    y = Corners(i,2);
    z = Corners(i,3);
    [q1,q2,q3,q4,q5] = IK(x,y,z,a2,a3,d1,d5,dE);
    Solution(i,1) = q1;
    Solution(i,2) = q2;
    Solution(i,3) = q3;
    Solution(i,4) = q4;
    Solution(i,5) = q5;
    
    %Check against forewards kinematics
    [x,y,z] = FWK(a2,a3,d1,d5,dE,q1,q2,q3,q4,q5);
    FWSolution(i,1) = x;
    FWSolution(i,2) = y;
    FWSolution(i,3) = z;
end
Solution
FWSolution