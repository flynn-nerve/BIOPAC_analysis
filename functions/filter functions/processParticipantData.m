function processParticipantData(participant, inputBIOPACFileNames,inputEventFileNames, inputCondition, inputFilePath)
%PROCESSPARTICIPANTDATA Input list of biopac file names, file path, 
%condition and events list file names and perform processing functions
%   Given a list of iterable filenames and event sheet filenames, run
%   through the list and for each file process the raw EMG data, look for
%   peak data and write the resulting data to one or more output data files

%% Iterate Through BIOPAC Files to Process Participant Data **NOEXO condition
for k=1:numel(inputBIOPACFileNames)
    
    % Extract useful components from file name/path for use in functions
    fullFilePathName = strcat(inputFilePath, inputCondition, '\', inputBIOPACFileNames(k));
    [filepath,name,ext] = fileparts(fullFilePathName);
    fullEventFilePathName = strcat(inputFilePath, inputCondition, '\', inputEventFileNames(k));
    [filepath_excel,name_excel,ext_excel] = fileparts(fullEventFilePathName);
    
    % Run both filters on the raw EMG data and return the output
    [FIR_EMG,RMS_EMG] = filterData(filepath, name, ext);
    filteredEMG = [FIR_EMG,RMS_EMG];
    
    % Use event log to determine and save peak data from processed EMG vals
    [trimmedEvents, trimmedEvents_Height] = trimEventLog(filepath_excel,name_excel,ext_excel);
    [peakData, peakData_Headers] = findPeaks(RMS_EMG, trimmedEvents, trimmedEvents_Height);
    
    % Write data to csv
    writeData(participant, inputCondition, name, filteredEMG, peakData, peakData_Headers);
end

end

