clear
close all
%Exercise 2
%b)
thresh = 10^(-9);
v=100;
t_bar = 1000.;
F = mvnrnd([2,3],[1,1.5;1.5,3],t_bar);
%Here I just do some arranging so that it passes correct input to the
%function
pt(1:t_bar)=1/t_bar;
pt=pt.';
A = {F,pt};

[u,sig] = MaxLikelihoodFPLocDispT(A,v,thresh);
u
sig
