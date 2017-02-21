%Exercise 1
%a) For a (univariate) lognormal distribution E{X}=e^(mu+sig^2/2) and
%V{X}=e^(2mu+sig^2)(e^(sig^2)-1). A little algebra can yield:
function [mu, sig2] = lognormal(E,V);
mu = log(E/sqrt(V/E^2+1));
sig2 = log(V/E^2+1);
%Alternatively Matlab as a built in function called lognstat(mu,sigma)
%https://www.mathworks.com/help/stats/lognstat.html

