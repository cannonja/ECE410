% This code demonstrates the use of Matlabs 'svmtrain' and 
% 'svmclassify' functions

clear
close all

load fisheriris

figure(1)
gscatter(meas(:,1), meas(:,2), species,'rgb','osd');
xlabel('Sepal length');
ylabel('Sepal width');

figure(2)
gscatter(meas(:,3), meas(:,4), species,'rgb','osd');
xlabel('Petal length');
ylabel('Petal width');


% Find a line separating the Fisher iris data on versicolor and 
% virginica species, according to the petal length and petal width
% measurements. These two species are in rows 51 and higher of the data 
% set, and the petal length and width are the third and fourth columns.
figure(3)
xdata = meas(51:end,3:4); % data is petal length and petal width
group = species(51:end);  % either versicolor or virginica

% train the classifier
svmStruct = svmtrain(xdata,group,'showplot',true);


% let's classify tthe point (5, 2), i.e. and iris with 
% Petal length = 5 and Petal width = 2
species = svmclassify(svmStruct,[5 2],'showplot',true)

hold on;
plot(5,2,'ro','MarkerSize',12);
hold off
% species =
% 'virginica'

sup_vect = svmStruct.SupportVectors
size(sup_vect)