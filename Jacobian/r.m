function [ vector ] = r( T, frame,A,Z)
%r Returns position vectors from point A to point Z, with respect to some frame
% eg to find 0r23: = r(T,0,2,3)
%Note: must run FWi.m in order to get T
%T is a 1 x n cell array of all the atomic T matrices

%So far function has not been tested for many exception cases, when using,
%ensure that A>Z

%only if f<=A
if A>Z
    vector = -1*r(T,frame,Z,A);
    return;
end

v = 0;
for k = A:Z-1
    R = getR(frame,k,T); %get rotation matrices
    rr = getr(k,T); %get position vector
    v = v+R*rr; %Add each new term
end
    
vector = v;
end

function rr = getr(k, T)

    rr = T{k+1}(1:3,4);
end

function R = getR(f,k,T)

t = eye(4);
for i =f+1:k
    t = t*T{i};
end

R = t(1:3,1:3);

end
