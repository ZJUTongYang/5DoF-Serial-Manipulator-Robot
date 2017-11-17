function [ centre, Faces ] = plotJengaTower( x, y, angle, face)
%plotJengaTower Plots a Jenga tower in 3D space
%   Uses standard Jenga dimensions
%   x, y - dictate the centroid of the tower base
%   angle - dictates how much the tower rotates about the robot base
%   face - sometimes you may not care about the centroid of the tower,
%   only the distance to the face. If face is a number, then offset is
%   treated as the distance to the face

%% Jenga dimensions
L = 7.5;
W = 7.5;
H = 27;

%% Choosing centroid value
x
y
z = 0
if isnumeric(face)
    D = face;
    x = D+L/2; y = 0; z = 0;
end

% %plot centroid before tower has rotated
% plot3(x,y,z,'rx')
% hold on
% grid on;

%% Drawing faces
base=[x-L/2 x+L/2 x+L/2 x-L/2 x-L/2; y-W/2 y-W/2 y+W/2 y+W/2 y-W/2; 0 0 0 0 0];
top = [x-L/2 x+L/2 x+L/2 x-L/2 x-L/2; y-W/2 y-W/2 y+W/2 y+W/2 y-W/2; H H H H H];
right = [x-L/2 x+L/2 x+L/2 x-L/2 x-L/2; y-W/2 y-W/2 y-W/2 y-W/2 y-W/2; z z z+H z+H z];
left = [x-L/2 x+L/2 x+L/2 x-L/2 x-L/2; y+W/2 y+W/2 y+W/2 y+W/2 y+W/2; z z z+H z+H z];
front = [x-L/2 x-L/2 x-L/2 x-L/2 x-L/2; y-W/2 y-W/2 y+W/2 y+W/2 y-W/2; z z+H z+H z z];
back = [x+L/2 x+L/2 x+L/2 x+L/2 x+L/2; y-W/2 y-W/2 y+W/2 y+W/2 y-W/2; z z+H z+H z z];

% %plotting the tower before it has rotated about the robot's origin
% plot3(base(1,:),base(2,:),base(3,:));
% hold on;
% plot3(top(1,:),top(2,:),top(3,:));
% plot3(back(1,:),back(2,:),back(3,:));
% plot3(front(1,:),front(2,:),front(3,:));
% plot3(left(1,:),left(2,:),left(3,:));
% plot3(right(1,:),right(2,:),right(3,:));

%% Rotating the tower
R = [cosd(angle) -sind(angle) 0; sind(angle) cosd(angle) 0; 0 0 1;];
base = R*base;
top = R*top;
left = R*left;
right = R*right;
front = R*front;
back = R*back;
centre = [x;y;z]
centre = R*centre

%% Plotting the Tower

%plot centroid
plot3(centre(1),centre(2),centre(3),'rx');
hold on;
grid on;

%plot tower faces
plot3(base(1,:),base(2,:),base(3,:));
plot3(top(1,:),top(2,:),top(3,:));
plot3(back(1,:),back(2,:),back(3,:));
plot3(front(1,:),front(2,:),front(3,:));
plot3(left(1,:),left(2,:),left(3,:));
plot3(right(1,:),right(2,:),right(3,:));
plot3(0,0,0,'r+');

%% Setting Axis Limits
xlimit = [-30 30];
xlim(xlimit); %actually the y_0 axis
xlabel('x_0');

ylimit = [-30 30];
ylabel('y_0');
ylim(ylimit); %actually the z_0 axis

zlimit = [-30 100];
zlabel('z_0');
zlim(zlimit);

Faces = {front, back; left, right; base, top};
end

