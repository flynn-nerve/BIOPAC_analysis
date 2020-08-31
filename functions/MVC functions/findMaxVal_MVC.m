function max_vals = findMaxVal_MVC(RMS_MVC)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% Iterate through table and find max val for each column (muscle)

% get height of table (height does not work in this case
size_MVC = size(RMS_MVC);
height_MVC = size_MVC(1);
width_MVC = size_MVC(2);

% set an arbitrarily low number for each spot in the max val array that can
% be easily overwritten by actual data
max_vals = zeros(1,width_MVC);
for j=1:width_MVC
    max_vals(j) = -500;
end

% iterate through each column and check for new highest value, save result
for k=1:height_MVC
    for m=1:width_MVC
        if RMS_MVC(k,m) > max_vals(m)
            max_vals(m) = RMS_MVC(k,m);
        end
    end
end

end

