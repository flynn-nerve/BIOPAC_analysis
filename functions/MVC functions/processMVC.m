function processMVC(participant, inputMVCFileNames, MVC_dir_name, inputFilePath)
% normalizeMVC
%   Normalization of EMG signal
%   1. filter and apply RMS
%   2. find max value per muscle
%   3. use max value to normalize muscle data and express as a percentage

%% Iterate through files within MVC file directory and perform steps
for k=1:numel(inputMVCFileNames)
    
    % Extract useful components from file name/path for use in functions
    MVCFilePathName = strcat(inputFilePath, MVC_dir_name, '\', inputMVCFileNames(k));
    [filepath_MVC,name_MVC,ext_MVC] = fileparts(MVCFilePathName);
    
    % Apply FIR filter and RMS calculations to MVC files
    [muscles,RMS_MVC] = filterMVCData(filepath_MVC, name_MVC, ext_MVC); 
    
    % You will want to put a peakData function here (should be different
    % from the one that is currently run on the larger set of BIOPAC data
    % ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    % findPeaksMVC();
    
    % Find the max value (per muscle) within the MVC
    maxMVCVals = findMaxVal_MVC(RMS_MVC);
    
    % Use the max value to normalize the muscle filtered data and express
    % as a percentage
    normalizedMVCData = normalizeMVC(maxMVCVals, RMS_MVC, muscles);
    
    % Write data to csv
    outputMVCFilePath = writeMVCData(participant, MVC_dir_name, normalizedMVCData, name_MVC);
    
    % plot the data and save to files
    % If you implement a peak data function for the MVC files, you will
    % want to write those data out to an excel file or something as well
    % plotMVC(normalizedMVCData, name_MVC, outputMVCFilePath, peakData);
    plotMVC(normalizedMVCData, name_MVC, outputMVCFilePath);
end

end

