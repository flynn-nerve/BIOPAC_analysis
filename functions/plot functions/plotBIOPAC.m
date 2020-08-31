function plotData(inputEMGData,inputLabel,inputFileName)
%PLOTDATA Summary of this function goes here
%   Detailed explanation goes here

% look up linspace
% y = linspace(x1,x2,n); - "Generate linearly spaced vector"
% generates an array "y" of n points spaced evenly between x1 and x2, the
% spacing between the poitns is (x2-x1)/(n-1)

% Look for tiledLayout() command for tiling multiple plots in the same
% image for Jose's actual stuff

% RMS vs Peak vs Avg. Peak
% plot(x1,y1,x2,y2,...,xn,yn,LineSpec) - LineSpec is colors, thickness,
% etc. for the lines in the plot
plot(1:height,x);
title(inputLabel)
legend('RMS','Peak','Avg. Peak')
% view -> plot browser

% example for saving plot
% plot(rand(5,5))
% ax = gca;
% exportgraphics(ax,'LinePlot.jpg')
end

