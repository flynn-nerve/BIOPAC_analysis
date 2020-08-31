function MVCFilePath = writeMVCData(inputParticipant, MVC_dir_name, normalizedMVCData, name_MVC)
%WRITEDATA Summary of this function goes here
%   Detailed explanation goes here

%% Create output file path
outputFilePath = 'C:\Users\Brian\Desktop\Jose Workspace\output files\';
participantFilePath = strcat(outputFilePath, inputParticipant);
MVCFilePath = strcat(participantFilePath, '\', MVC_dir_name);

if ~exist(MVCFilePath, 'dir') 
    mkdir(MVCFilePath);
end

%% Write data into an excel sheet
MVCFilePathandName = strcat(MVCFilePath, '\', name_MVC, ".csv");

writetable(normalizedMVCData, MVCFilePathandName, 'WriteVariableNames', true);

end

