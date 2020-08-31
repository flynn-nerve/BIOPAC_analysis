function [FIR_EMG,RMS_EMG] = filterData(inputFilePath, inputFileName, inputFileExtension)
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
raw_EMG = readtable(fileName,'ReadVariableNames',false,'PreserveVariableNames',true);
Height_dataset = height(raw_EMG);

% crop dataset table down to just raw EMG values to work with
raw_EMG_trimmed = raw_EMG(1:Height_dataset,2:17);

%% FIR Filter EMG Data
% turn trimmed data table into array for further processing
% run data array through FIR filter
FIR_EMG = filterEMG_2(table2array(raw_EMG_trimmed), samplingFreq, lowFcutoff, hiFcutoff);

%% Calculate Root Mean Square (RMS) from Filtered EMG Data
RMS_EMG = RMS_changing(FIR_EMG, winLen, overlap, zeropad);

end

