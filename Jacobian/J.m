function [ J ] = Jacob( i,T )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

w = 4;
J = [cross(z(T,0,i),r(T,0,0,w)-r(T,0,0,i)); z(T,0,i)];

end

