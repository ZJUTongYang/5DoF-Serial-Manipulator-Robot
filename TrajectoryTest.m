%% Demonstrating Trajectories
%A test for the previously used loading bay positions
%Due to Matlab software issues whereby passed function handles do not
%appropriately parse symbolic input variables as they should, the following
%trajectories had to be hardcoded using the output cubic polynomial
%a0,a1,a2,a3 coefficients

%Due to the path tracing algorithm, trajectories are drawn backwards, from
%final to initial points

close all
figure,
hold on
plot3(0,0,0,'r+');
hold on
grid on
syms t
xlimit = [-30 30];
xlim(xlimit); %actually the y_0 axis
xlabel('x_0');

ylimit = [-30 30];
ylabel('y_0');
ylim(ylimit); %actually the z_0 axis

zlimit = [-30 100];
zlabel('z_0');
zlim(zlimit);
%% Jenga Tower
plotJengaTower( 23, 0, 0, false);
%%
Q1 = [];
Q2 = [];
Q3 = [];
Q4 = [];
Q5 = [];

%% First trajectory
for i=1:0.2:10
    x = (23*2^(1/2))/2;
    y = (23*2^(1/2))/2;
    z = 108/i^2 -72/i^3;
    
    plot3(x,y,z, 'go')
    hold on
    drawnow;
    pause(0.2)
    [ q1, q2, q3, q4, q5 ] = IK(x,y,z,a2,a3,d1,d5,dE);
    Q1 = [Q1;q1];
    Q2 = [Q2;q2];
    Q3 = [Q3;q3];
    Q4 = [Q4;q4];
    Q5 = [Q5;q5];
    
end
trajectory1const = [Q1 Q2 Q3 Q4 Q5];
%%
Q1 = [];
Q2 = [];
Q3 = [];
Q4 = [];
Q5 = [];
%% Second Trajectory

for t=1:0.2:10
    x = (23*2^(1/2))/2-(69*(2^(1/2) - 2))/(2*t^2)+(23*(2^(1/2) - 2))/t^3;
    y = (23*2^(1/2))/2-(69*2^(1/2))/(2*t^2)+(23*2^(1/2))/t^3;
    z = 36-108/t^2 +72/t^3;
    plot3(x,y,z, 'co')
    hold on
    drawnow;
    pause(0.2)
    [ q1, q2, q3, q4, q5 ] = IK(x,y,z,a2,a3,d1,d5,dE);
    Q1 = [Q1;q1];
    Q2 = [Q2;q2];
    Q3 = [Q3;q3];
    Q4 = [Q4;q4];
    Q5 = [Q5;q5];
end

trajectory2const = [Q1 Q2 Q3 Q4 Q5];
%% Minimum and Maximum Joint values
%These values should be cross referenced with previously identified joint constraints
Trajectory1 = [max(trajectory1const(1:end,1)) min(trajectory1const(1:end,1));
    max(trajectory1const(1:end,2)) min(trajectory1const(1:end,2));
    max(trajectory1const(1:end,3)) min(trajectory1const(1:end,3));
    max(trajectory1const(1:end,4)) min(trajectory1const(1:end,4));
    max(trajectory1const(1:end,5)) min(trajectory1const(1:end,5))]

Trajectory2 = [max(trajectory2const(1:end,1)) min(trajectory2const(1:end,1));
    max(trajectory2const(1:end,2)) min(trajectory2const(1:end,2));
    max(trajectory2const(1:end,3)) min(trajectory2const(1:end,3));
    max(trajectory2const(1:end,4)) min(trajectory2const(1:end,4));
    max(trajectory2const(1:end,5)) min(trajectory2const(1:end,5))]