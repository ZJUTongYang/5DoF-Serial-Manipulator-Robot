%%Establishing the workspace of the 2 arms in the Sagittal Plane of a 5DOF
%%serial manipulator

%% Clearing workspace
% clc
% clear workspace
close
%% CONSTANTS
L = 7.5;
W = 2.5*3;
H = 1.5*(54/3);

%upper bounds for fixed parameters, like link length
%established arbitrarily
L1_UB = 100;
L2_UB = 100;
D_UB = 100;
%% Choosing Arm Parameters (by command line input)
%choose these to input them manually on the command line
% L1= input('Choose [L1 L2 D]\n') ;
% L2 = input('');
% D = input('');
% 
% assert((L1>0)&&(L1<L1_UB));%first link; hind-arm
% assert((L2>0)&&(L2<L2_UB));%second link; fore-arm
% assert((D>0)&&(D<D_UB));%distance to start of jenga block
% 
% %variables
% q1LB = input('Choose q1 Lower and Upper Bound [LB UB]\n') ;
% q1UB = input('');
% q2LB = input('Choose q2 Lower and Upper Bound [LB UB]\n');
% q2UB = input('');

%% Choosing Arm Parameters (by hardcoding)
L1 = 28;
L2 = 18;
D = 22;
baseHeight = 12;
gripLength = 7; %Length of the end effector, always pointing downwards
step = 3; %Step size for faster processing

%zero position use -> z = [0 0 0 0]
%    Min Max Min Max
z = [-80  30  -60 60]; %In deg
q1LB = deg2rad(z(1));
q1UB = deg2rad(z(2));
q2LB = deg2rad(z(3));
q2UB = deg2rad(z(4));
%% Stepsize for dots
delta_q1 = pi/100;
delta_q2 = pi/100;
%% Forward Kinematics
Link1 = q1LB:delta_q1:q1UB;
Link2 = q2LB:delta_q2:q2UB;


for i = 1:step:length(Link1)
    for j =1:step:length(Link2)
        [x y z a b c] = FW(Link1(i),Link2(j),L1,L2);
        plot(y,z+baseHeight-gripLength,'g.');
        hold on
        if (i==1)&&(j==1)
            line([0 b],[0+baseHeight c+baseHeight]);
            line([b y],[c+baseHeight z+baseHeight]);
            g1 = line([y y],[z+baseHeight z+baseHeight-gripLength]);
            plot(y,z+baseHeight-gripLength,'o');
        end
%         line([0 b],[0 c]);
%         line([b y],[c z]);
        
    end
    
end
%% Plotting jenga tower
tower = rectangle('position',[D 0 W H]);
xlim([-10 60]); %actually the y_0 axis
xlabel('y_0');
ylabel('z_0');
ylim([-10 60]); %actually the z_0 axis
