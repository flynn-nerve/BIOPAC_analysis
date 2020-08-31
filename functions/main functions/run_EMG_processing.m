%% Currently set up for 12 participants 
% Change participant_num value if number of participants change

participant_num = 12;

% automatically call processEMG main script on participants, passing
% through the correct string is important for finding files
for k=6:1:participant_num
    participant_num_str = int2str(k);
    if k < 10
        participant = strcat('B0', participant_num_str);
        processEMG(participant);
    elseif participant_num > 10
        participant = strcat('B', participant_num_str);
        processEMG(participant);
    end
end