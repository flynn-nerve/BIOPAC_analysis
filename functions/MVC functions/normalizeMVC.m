function [normalizedMVC] = normalizeMVC(maxMVCVals, RMS_MVC, muscles)
%NORMALIZEMVC Summary of this function goes here
%   Detailed explanation goes here

%% Iterate through each column from RMS_MVC and populate new table containing normalized results

% Get number of rows (height) and columns (width) of table because these
% values vary per file
size_MVC = size(RMS_MVC);
height_MVC = size_MVC(1);
width_MVC = size_MVC(2);

% Create a new cell array to be input into the table as variable names
% (headers), the first column will be 'Time' which was cut out previously
headers = {width_MVC};
headers(1) = {'Time'};

% Add the muscles (headers in original file) back to the table as new
% variables (headers)
for i=2:width_MVC
    headers(i) = muscles(i-1);
end

% Create and add to a cell array of variable types (they should all be
% double) so that the generate table function will work properly
varTypes = {width_MVC};
for j=1:width_MVC
    varTypes(j) = {'double'};
end

% create a new table using headers to hold normalized values
normalizedMVC = table('Size',[height_MVC width_MVC],'VariableTypes',varTypes,'VariableNames',headers);

% first reinsert and populate 'Time' column
timeVal = 0;

for k=1:height_MVC
    normalizedMVC(k,1) = num2cell(timeVal);
    timeVal = timeVal + 0.001;
end

% start filling in actual normalized values
for m=2:width_MVC
    for k=1:height_MVC
        normalizedMVC(k,m) = num2cell(RMS_MVC(k,m-1) / maxMVCVals(m-1));
    end
end

end

