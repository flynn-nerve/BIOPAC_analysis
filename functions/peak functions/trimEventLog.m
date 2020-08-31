function [trimmedEvents,eventHeight] = trimEventLog(inputFilePath, inputFileName, inputFileExtension)
%TRIMEVENTLOG Summary of this function goes here
%   Detailed explanation goes here

%% Set Global Variables
% Construct full file path + name
fileName = strcat(inputFilePath, '\', inputFileName, inputFileExtension);

%% Extract Required Data from Full Event Log
% read in excel spreadsheet and get size values
full_event_data = readtable(fileName);
event_data_height = height(full_event_data);

% extract useful event data from spreadsheet
trimmedEvents = full_event_data(1:event_data_height,1:4);
eventHeight = event_data_height;

end

