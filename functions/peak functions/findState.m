function [label, nextState] = findState(state)
%FINDBOXANDACTION Input current state and output box number and action
%   Use the stored state value (last iteration's "next state") to determine
%   the next Box number and Action for labeling purposes within the calling
%   function

%% Use switch case method to iterate through boxes
% The order is known because it is a test variable and is as follows:
%   Box 1 lift, Box 1 put down, box 2 lift, box 2 put down, box 3 lift, box
%   3 put down, box 3 lift, box 3 put down, box 2 lift, box 2 put down, box
%   1 lift, box 1 put down.
%
%   The state is only ever 0 to indicate that the very first "activity" is
%   the participant walking over to the boxes for the first time and
%   getting ready to perform the first lift. This condition will only ever
%   occur at the beginning and state should never be 0 again

    % Determine what action (lift, put down) we are performing with the box
    % based on the previous action
    switch state
        case 0
            label = "No_Box";
            nextState = 1;
        case 1
            label = "Box_1";
            nextState = 2;
        case 2
            label = "Box_2";
            nextState = 3;
        case 3
            label = "Box_3";
            nextState = 4;
        case 4
            label = "Box_3";
            nextState = 5;
        case 5
            label = "Box_2";
            nextState = 6;
        case 6
            label = "Box_1";
            nextState = 1;
        otherwise
            % Something broke, restart
            nextState = 0;
    end    
end

