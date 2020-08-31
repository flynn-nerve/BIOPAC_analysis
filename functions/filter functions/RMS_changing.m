% Code for the calculation of the RMS for the filtered data
% Calculates windowed (over- and non-overlapping) RMS of a signal using the specified windowlength
% y = rms(signal, windowlength, overlap, zeropad)
% signal is a 1-D vector
% windowlength is an integer length of the RMS window in samples
% overlap is the number of samples to overlap adjacent windows (enter 0 to use non-overlapping windows)
% zeropad is a flag for zero padding the end of your data...(0 for NO, 1 for YES)
% ex. y=rms(data_filtered, 50, 49, 49).  Calculate RMS with window of length 50 samples, 
%       overlapped by 49 samples each (i.e., it iterates by just one row each time), and 
%       zeropad by 49 so that when it reaches the final row, it has enough
%       zeros to perform the average without crashing the program.
% For our purposes, y=rms(data_filtered, 500, 499, 499). 

function RMS_data_filtered = RMS_changing(signal, windowlength, overlap, zeropad)

delta = windowlength - overlap;

%% CALCULATE RMS

%Create a matrix with zeros with the same size as signal
RMS_data_filtered = zeros(size(signal,1), size(signal,2));

% Square the samples
squaredmatrix = signal.^2;

% Pad the matrix to have zeros -- without this padding, it cannot do the
% mean values
squaredmatrix(size(signal,1)+zeropad,:) = 0;


%j represents the column 
for j = 1:1:size(signal,2)

    %i represents the row
    for i = 1:delta:size(signal,1)
        
        % Average and take the square root of each window
        RMS_data_filtered(i,j) = sqrt(mean(squaredmatrix(i:i+windowlength-1,j)));
    end


end





