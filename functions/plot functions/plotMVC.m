function plotMVC(normalizedMVCData, name_MVC, outputFilePath)
%PLOTMVC Summary of this function goes here
%   Detailed explanation goes here

%% Get size of data

% Get number of rows (height) and columns (width) of table because these
% values vary per file
size_MVC = size(normalizedMVCData);
height_MVC = size_MVC(1);
width_MVC = size_MVC(2);

%% Plot

% the MVC data files will have either 3, 5 or 7 columns so account for
% those possibilities when plotting data

% set X val for shorter code
X = 1:height_MVC;

% turn visibility off so that each plot does not have to display and eat
% computer resources
holdFigure = figure("visible",false);

% create multiple-line plot by iterating through columns and adding to plot
% while maintining x axis
for k=2:width_MVC
    Y = normalizedMVCData.(k);
    plot(X, Y);
    % hold plot so that other lines can be added
    hold on
end

% turn hold back off
hold off

% Add title and labels to the figure
title('EMG Muscle Normalized');
xlabel('Sample Number');
ylabel('Normalized Value');

% If you want to remove the legend, do it here
muscle_names = normalizedMVCData.Properties.VariableNames(2:width_MVC);
legend(muscle_names, 'Location','best','FontSize',8);

%% Save plot to disk

saveFilePath = strcat(outputFilePath, '\', name_MVC, ".pdf");
saveas(holdFigure, saveFilePath);
saveFilePath = strcat(outputFilePath, '\', name_MVC, '_mat', ".fig");
saveas(holdFigure, saveFilePath);

end

