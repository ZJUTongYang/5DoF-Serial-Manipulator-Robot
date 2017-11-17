function [ PosRef, OrientRef,A] = generateTrajectory( initposition, initvelocity, Rinit, finalposition, finalvelocity, Rfinal, t)
%UNTITLED Summary of this function goes here
% %   Detailed explanation goes here
% xi = initposition(1);
% yi = initposition(2);
% zi = initposition(3);
% 
% xf = finalposition(1);
% yf = finalposition(2);
% zf = finalposition(3);
% 
% x_doti = initvelocity(1);
% y_doti = initvelocity(2);
% z_doti = initvelocity(3);
% 
% x_dotf = finalvelocity(1);
% y_dotf = finalvelocity(2);
% z_dotf = finalvelocity(3);

%% cubic Polynomial interpolation for displacement and velocity
a = [1 0 0 0; 0 1 0 0; 1 t t^2 t^3; 0 1 2*t 3*t^2];
A = [];
global xref;
for i =1:3
    syms a0 a1 a2 a3 t real;

    %A = [a0 a1 a2 a3]';

    b = [initposition(i); initvelocity(i); finalposition(i); finalvelocity(i)];

    [X,R]=linsolve(a,b)

    a0 = X(1);
    a1 = X(2);
    a2 = X(3);
    a3 = X(4);

    switch i
        case 1 %x
            A = [A;a0 a1 a2 a3];
            
        xref = @(t) a0 + a1*t +a2*t*t + a3*t*t*t
        x_dotref = @(t) a1 + 2*a2*t +3*a3*t^2;
        case 2 %y
             A = [A;a0 a1 a2 a3];
        yref = @(t) a0 + a1*t +a2*t^2 + a3*t^3;
        y_dotref = @(t) a1 + 2*a2*t +3*a3*t^2;
        case 3 %z
             A = [A;a0 a1 a2 a3];
        zref = @(t) a0 + a1*t +a2*t^2 + a3*t^3;
        z_dotref = @(t) a1 + 2*a2*t +3*a3*t^2;
    end

end

PosRef = {xref, yref, zref, x_dotref, y_dotref, z_dotref}

%% cubic Polynomial interpolation for orientation
Ri_f = (Rinit)'*Rfinal

thetaf = 2*acos(0.5*sqrt(1 + Ri_f(1,1) + Ri_f(2,2) + Ri_f(3,3)))
k = (2*sin(thetaf))^-1 .* [Ri_f(3,2)-Ri_f(2,3); Ri_f(1,3)-Ri_f(3,1); Ri_f(2,1)-Ri_f(1,2)]

syms b0 b1 b2 b3 real

%assume initial angular velocity and final angular velocity are 0
b = [0; 0; thetaf; 0];

[X,R]=linsolve(a,b)

    b0 = X(1);
    b1 = X(2);
    b2 = X(3);
    b3 = X(4);
A = [A;b0 b1 b2 b3];
thetaref = @(t) b0 + b1*t + b2*t^2 + b3*t^3;
wref = @(t) b1 + b2*t+ b3*t^2;

OrientRef = {thetaref, wref};
end

