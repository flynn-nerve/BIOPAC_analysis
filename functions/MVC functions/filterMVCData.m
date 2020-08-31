function [headers,RMS_MVC] = filterMVCData(inputFilePath, inputFileName, inputFileExtension)
%GENOUTPUT Summary of this function goes here
%   Detailed explanation goes here

%% Set Global Variables
% Set values for EMG filter/RMS function inputs for utility
samplingFreq = 1000;    % sampling frequency (Hz)
lowFcutoff = 28;        % low frequency high-pass cutoff (Hz)
hiFcutoff = 500;        % high frequency low-pass cutoff (Hz)
winLen = 500;           % window length for RMS samples
overlap = 499;          % sample overlap
zeropad = 499;          % zero padding to prevent crash

% Construct full file path + name
fileName = strcat(inputFilePath, '\', inputFileName, inputFileExtension);

%% Extract Raw EMG Values from Raw Dataset 
% read in excel spreadsheet and get size values
% we do not need the VariableNames, do not read to supress warnings later
% when writing
raw_MVC = readtable(fileName,'ReadVariableNames',true,'PreserveVariableNames',true);
size_MVC = size(raw_MVC);
height_MVC = size_MVC(1);
width_MVC = size_MVC(2);
raw_MVC = raw_MVC(1:height_MVC,2:width_MVC);

% extract headers (muscle names) from table properties and cut off 'time'
headers = raw_MVC.Properties.VariableNames;

%% FIR Filter EMG Data
% turn trimmed data table into array for further processing
% run data array through FIR filter
FIR_MVC = filterEMG_2(table2array(raw_MVC), samplingFreq, lowFcutoff, hiFcutoff);

%% Calculate Root Mean Square (RMS) from Filtered EMG Data
RMS_MVC = RMS_changing(FIR_MVC, winLen, overlap, zeropad);

end

