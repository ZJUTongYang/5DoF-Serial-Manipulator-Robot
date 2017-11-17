function [ J ] = Jacob( T,o,w )
%Jacob Finds the Jacobian from some given point w with respect to a starting given point,
%reference frame is always 0, to change it, you must multiply the result
%with a rotation matrix

%o is the index in the T matrix corresponding to the first transformation
%from the intertial frame; in most cases this will be the index
%corresponding to T0_1

%Note: must run FWi.m in order to get T
%T is a 1 x n cell array of all the atomic T matrices

J=[];
for i = o:w
    J = horzcat(J,[cross(z(T,0,i),r(T,0,0,w)-r(T,0,0,i)); z(T,0,i)]);
end

end

