function [ vector ] = z( T, frame,k)
%z Finds the Z axis for some set of axes k, with respect to some reference frame
%Note: must run FWi.m in order to get T
%T is a 1 x n cell array of all the atomic T matrices


t = eye(4);
for i =frame+1:k
    t = t*T{i};
end

vector = t(1:3,3);
end