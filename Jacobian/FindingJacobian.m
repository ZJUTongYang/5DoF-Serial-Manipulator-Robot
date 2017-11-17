%% Script for finding the Jacobian
% Please double check results before using and after using, I still haven't
% fully tested the functions for all cases yet
%% Clearing workspace
% clc
% clear workspace
close
%% Jenga CONSTANTS
L = 7.5;
W = 2.5*3;
H = 1.5*(54/3);

%% Robot DH Paramaters
% a2 = 20%A(1)%20;
% a3 = 20%A(2)%20;
% d1 = 10%A(3)%20;
% d5 = 4;
% dE = 3;
% gripLength = d5 + dE; %Length of the end effector, always pointing downwards
syms a2 a3 d1 real %d5 dE

%% Getting Symbolic T Matrices
syms q1 q2 q3 q4 q5 real;
[T, Xt, Yt, Zt,EE,x,y,z] = FWi(q1, q2,q3, q4, q5, d1,a2,a3,0,0);

%T is a cell array of our atomic T matrices
%eg T0_1, T1_2, T3_4 etc

%% Jacobian
%Finds the Jacobian in origin of frame 0. 
%Does so by calculating each column up to w, which is indexed
%as 5 in the T cell matrix
[ J ] = Jacob(T,1,5)
simplify(J)

%% Jacobian Inversion
%5DOF robot, there is no motion about the x4 axis
T0_4 = T{1}*T{2}*T{3}*T{4};
T4_0 = inv(T0_4);
R4_0 = T4_0(1:3,1:3);

%j = [R4_0 zeros(3,3);zeros(3,3) R4_0]*J

