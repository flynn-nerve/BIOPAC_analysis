%% Input the number of participants and the path to your workspace here

% for this code test there are only 12 participants but you could
%   accommodate more with a different experiment if desired
participant_num = 12;

% your filepath should look something like this:
%   'C:\Users\<your_username>\Desktop\<your_workspace>'
workspacePath = 'C:\Users\Brian\Desktop\Jose Workspace';

%% Using the above values, process the data
% If you want a different starting point, change the first value in the
% for loop
% example: 
%   for k=5:1:participant_num
%   this will start at participant 5 and go until <participant_num>

% passing in the correct string is important for finding files and this is
%   the simplest way to automate for the rest of the code (the number needs
%   to be separated from the participant "B" in order to generate other
%   filenames so this is convenient)
for k=1:1:participant_num
    participant_num_str = int2str(k);
    if k < 10
        participant = strcat('B0', participant_num_str);
        processEMG(participant, workspacePath);
    elseif participant_num > 10
        participant = strcat('B', participant_num_str);
        processEMG(participant, workspacePath);
    end
end