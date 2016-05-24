clear
close all

% Train SVM Classifiers Using a Gaussian Kernel

% This example shows how to generate a nonlinear classifier with Gaussian 
% ('rbf') kernel function. First, generate one class of points inside the 
% unit disk in two dimensions, and another class of points in the annulus 
% from radius 1 to radius 2. Then, generate a classifier based on the 
% data first with the default linear kernel and then the Gaussian radial 
% basis function kernel. The linear classifier is obviously unsuitable  
% for this problem, since the model is circularly symmetric.  


% Generate 100 points uniformly distributed in the unit disk. To do so, 
% generate a radius r as the square root of a uniform random variable, 
% generate an angle t uniformly in (0, 2*pi), and put the point at 
% (r cos( t ), r sin( t )).

rng(1); % For reproducibility
r = sqrt(rand(100,1)); % Radius
t = 2*pi*rand(100,1);  % Angle
data1 = [r.*cos(t), r.*sin(t)]; % Points

% Generate 100 points uniformly distributed in the annulus. The radius 
% is again proportional to a square root, this time a square root of 
% the uniform distribution from 1 through 4.
r2 = sqrt(3*rand(100,1)+1); % Radius
t2 = 2*pi*rand(100,1);      % Angle
data2 = [r2.*cos(t2), r2.*sin(t2)]; % points

% Plot the points, and plot circles of radii 1 and 2 for comparison.
figure;
plot(data1(:,1),data1(:,2),'r.','MarkerSize',15)
hold on
plot(data2(:,1),data2(:,2),'b.','MarkerSize',15)
ezpolar(@(x)1);ezpolar(@(x)2); % Easy to use polar coordinate plotter.
hold off


% Put the data in one matrix, and make a vector of classifications.
data3 = [data1;data2];
theclass = ones(200,1);
theclass(1:100) = -1;


% Train an SVM classifier with two different kernels

% try the default linear kernel first
svmStruct = svmtrain(data3,theclass,'showplot',true); 

  
% now try the rbf kernel
svmStruct = svmtrain(data3,theclass,'kernel_function','rbf',...
               'showplot',true);      
 
% let's classify a couple of points           
tst = [1 -0.4;1  -0.7]
classification = svmclassify(svmStruct,tst,'showplot',true)
