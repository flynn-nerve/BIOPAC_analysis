function processEMG(participant, workspacePath)
%PROCESSEMG Input participant (ex. 'B01') and file path to workspace, get names of files to process (data and events) and run each file through the proper processing scripts according to the condition of the test trial
%   This is the main function that is called on a participant, it will
%   iterate through all of the files within the condition (NOEXO, WEXO)
%   folders as specified by the paths as well as the MVC files. It is
%   important that the file structure and naming conventions are maintained
%   otherwise the scripts will not be able to find the right files. There
%   needs to be a corresponding events file for each EMG file in order for
%   the script to properly do peak finding. Files will be written to new
%   'output_files' location within workspace and organized within

%% Set File Path Variables for Automation

% Set folder path to location of data
% change this to location of participant data folders (where B01, B02, etc. is located)
path = strcat(workspacePath, '\participant data');

% Add participant (input), B01, B02, ..., etc., to file path string
filePath = strcat(path, '\', participant, '\');

% Declare 'condition' strings for easy file navigation/folder switching
condition1 = "NOEXO";
condition2 = "WEXO";

% Instead of renaming supplied files, extract participant number from
% participant string to create a new string that matches up with MVC folder
% names ('B01' -> 'S1 MVC', etc.)
participant_num = str2num(participant(2:3));
participant_num_str = int2str(participant_num);
MVC_dir_name = strcat('S', participant_num_str, " ", 'MVC');

%% Create Lists of Files In Target Directories with Different Extensions

% Generate a directory of file information from a folder, specifying which
% extensions should be contained within each struct
dir_EMG_NOEXO = dir(fullfile(path, participant, condition1, '*.txt'));
dir_EMG_WEXO = dir(fullfile(path, participant, condition2, '*.txt'));
dir_Events_NOEXO = dir(fullfile(path, participant, condition1, '*.xlsx'));
dir_Events_WEXO = dir(fullfile(path, participant, condition2, '*.xlsx'));
dir_MVC = dir(fullfile(path, participant, MVC_dir_name, '*.xlsx'));

% Extract file names from struct of file information and store in a cell
% table for easy access
BIOPAC_file_names_NOEXO = {dir_EMG_NOEXO.name};
BIOPAC_file_names_WEXO = {dir_EMG_WEXO.name};
ExcelEvent_file_names_NOEXO = {dir_Events_NOEXO.name};
ExcelEvent_file_names_WEXO = {dir_Events_WEXO.name};
MVC_file_names = {dir_MVC.name};

%% Process Participant Data

% Process BIOPAC files for each condition (WEXO/NOEXO)
processParticipantData(participant, BIOPAC_file_names_NOEXO, ExcelEvent_file_names_NOEXO, condition1, filePath);
processParticipantData(participant, BIOPAC_file_names_WEXO, ExcelEvent_file_names_WEXO, condition2, filePath);

% Process MVC files
processMVC(participant, MVC_file_names, MVC_dir_name, filePath);

end
