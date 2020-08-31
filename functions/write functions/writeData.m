function writeData(inputParticipant, inputCondition, inputName, filteredEMG, peakData, peakData_Headers, normalizedMVCData)
%WRITEDATA Summary of this function goes here
%   Detailed explanation goes here

%% Generate Header Arrays for File Output
% Muscles array will be used to generate all subsequent headers
muscles = ["LVL","RES_T9","RES_L4","RRF","RVL","LRF","RGASMed","LGASMed","LBF","LES_T9","LES_L4","RVM","RBF","LVM","RGASLat","LGASLat"];
musclesHeight = size(muscles);

% Initialize empty arrays for iterative filling in of variables
filterDataTable_Headers_FIR = [];
filterDataTable_Headers_RMS = [];
peakData_Headers = [];

% Iterate through array/list of muscles and append required classifiers off
% of each muscle for labeling purposes
for k=1:1:musclesHeight(2)
    filterDataTable_Headers_FIR = [filterDataTable_Headers_FIR, strcat(muscles(k), "_FIR")];
    filterDataTable_Headers_RMS = [filterDataTable_Headers_RMS, strcat(muscles(k), "_RMS")];
    peakData_Headers = [peakData_Headers, strcat(muscles(k), "_Peak"), strcat(muscles(k), "_Avg")];
end

% Add the two filterDataTable_Headers arrays side by side 16 channels for
% each) since that is how they will be displayed
filterDataTable_Headers = [filterDataTable_Headers_FIR, filterDataTable_Headers_RMS];

%% Create output file path
outputFilePath = 'C:\Users\Brian\Desktop\Jose Workspace\output files\';
dirPar = strcat('output files\', inputParticipant);
dirCond = strcat(dirPar, '\', inputCondition);
dirFilt = strcat(dirCond, '\filtered EMG data');
dirPeak = strcat(dirCond, '\peak data');
participantPath = strcat(outputFilePath, inputParticipant); 
%participantPath = ('C:\Users\Brian\Desktop\Jose Workspace\output files\' + 'Bxx')
conditionPath = strcat(participantPath, '\', inputCondition);
%contitionPath = ('C:\Users\Brian\Desktop\Jose Workspace\output files\Bxx' + 'xEXO')
if ~exist(dirPar, 'dir')
    mkdir(participantPath);
end
if ~exist(dirCond, 'dir')
    mkdir(conditionPath);
end
if ~exist(dirFilt, 'dir') 
    mkdir(conditionPath, 'filtered EMG data');
end
if ~exist(dirPeak, 'dir') 
    mkdir(conditionPath, 'peak data');
end

%% Write data into an excel sheet
filterFilePath = strcat("C:\Users\Brian\Desktop\Jose Workspace\output files\", inputParticipant, "\", inputCondition, "\filtered EMG data\", inputName, "_Filtered_EMG_Data", ".csv");
peakFilePath = strcat("C:\Users\Brian\Desktop\Jose Workspace\output files\", inputParticipant, "\", inputCondition, "\peak data\", inputName, "_Peak_Data", ".csv");

filterDataTable_Headers_String = string(filterDataTable_Headers);
peakData_Headers_String = string(peakData_Headers);
filterDataTable = array2table(filteredEMG, 'VariableNames', filterDataTable_Headers);
peakDataTable = array2table(peakData, 'VariableNames', peakData_Headers);

writetable(filterDataTable, filterFilePath, 'WriteVariableNames', true);
writetable(peakDataTable, peakFilePath, 'WriteVariableNames', true);

end

