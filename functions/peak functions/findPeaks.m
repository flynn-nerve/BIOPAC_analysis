function [peakData, peakData_Headers] = findPeaks(inputEMGData,inputEvents,inputHeight)
%FINDPEAKS Input EMG data and event data to find actual and average peaks 
%from EMG data using events as separators for sections of data
%   Detailed explanation goes here

%%
% Find the peak value within each of the event time window per box,
% Find the average value +/- 75 data points from the identified peak value in each event.
Peak_data = [];
% preallocate 16 elements in labels array
labels = zeros(size(16));
muscles = ["LVL","RES_T9","RES_L4","RRF","RVL","LRF","RGASMed","LGASMed","LBF","LES_T9","LES_L4","RVM","RBF","LVM","RGASLat","LGASLat"];

% Create variables for determining box being handles and action being
% performed with box for more easily labeling data
state = 1;

for k=4:2:inputHeight-2
    [label, state] = findState(state);
    for m=1:16
        % Create row header info from label components and store in array
        muscle = muscles(m);
        labels(k) = strcat(muscle, ' ', label, ' ', int2str(state));
        % Determine start and end rows for the segment of data we are
        % interested in (between box lift and put down)

        % Events list is an array of cells, split cells into numbers and
        % text and then evaluate each component separately for determining
        % start row locations
        startRowCell = table2array(inputEvents(k,1));
        startRowSplit = split(startRowCell);
        if string(startRowSplit(2)) == "min"
            startRow = str2double(startRowSplit(1)) * 60000;
        end
        if string(startRowSplit(2)) == "sec"
            startRow = str2double(startRowSplit(1)) * 1000;
        end
        
        % Same as above but for end row
        endRowCell = table2array(inputEvents(k+1,1));
        endRowSplit = split(endRowCell);
        if string(endRowSplit(2)) == "min"
            endRow = str2double(endRowSplit(1)) * 60000;
        end
        if string(endRowSplit(2)) == "sec"
            endRow = str2double(endRowSplit(1)) * 1000;
        end
        % force startRow and endRow to be a flat int to resolve taxing warning
        % can also use round() function
        subset = inputEMGData(round(startRow):round(endRow),m);
        subset_height = length(subset);
        peak = -1000;
        for n=1:subset_height
            if subset(n) > peak
                peak = subset(n);
                peak_loc = n;
            end
            % otherwise do nothing
        end
        low = peak_loc-75;
        high = peak_loc+75;
        if low < 1
            low = 1;
        end
        if high > subset_height
            high = subset_height;
        end
        peak_subset = subset(low:high,1);
        avg = mean(peak_subset);
        Peak_data((k-2)/2,((m*2)-1)) = peak;
        Peak_data((k-2)/2,((m*2))) = avg;
    end
end

peakData = Peak_data;
peakData_Headers = labels;
end