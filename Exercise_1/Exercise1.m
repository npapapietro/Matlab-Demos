clear
close all
%Exercise 1
%b)

%Inputs
E_X = 3;
V_X = 5;
Sample_Size = 10^5;

%Calling mean and variance function
[mu,sig2] = lognormal(E_X,V_X);
sig = sqrt(sig2);

%Using built in function to generate samples 
R = lognrnd(mu,sig,Sample_Size,1,1);

%Plotting the data
figure
plot(R,'.');
title('Lognormal Distribution vs Sample Size')
xlabel('Sample Size')
ylabel('Random numbers in Lognormal Distribution')
legend('Samples')

%Histogram with PDF overlay
figure
h=histogram(R,'Normalization','pdf');%empirical
h.NumBins = 10*log10(Sample_Size);
hold on
x = (0:.1:20);
y = lognpdf(x,mu,sig);%Exact
plot(x,y,'r');
legend('Empirical','Exact')
title('Normalized Histogram with PDF overlayed')

%Empirical CDF vs Exact CDF
figure
[f,x] = ecdf(R);%empirical
plot(x,f);
hold on
g = logncdf(x,mu,sig);%exact
plot(x,g);
legend('Empirical','Exact')
title('Empirical CDF and Exact CDF')
xlabel('x')
ylabel('\Phi(x)')
