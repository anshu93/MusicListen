% Threshold finder function

function[X] = Threshmagfinder(P,T) %Takes in the matrix and the length of the cut

%% Find the threshold magnitude
[row,cols] = size(P);
SortedPeaks = reshape(P,row*cols,1)'; %Put all the data into a vector
SortedPeaks = sort(SortedPeaks,'descend'); %Vector of peak amplitudes in descending order
TotalPeaksRequired = floor(30*T); % 30peaks/sec*time of clip
threshmag = SortedPeaks(TotalPeaksRequired); % Find the totalpeak'th largest value

%% Remove small peaks
for l = 1:row*cols
    if P(l) < threshmag %Set everything less than the threshold to zero
        P(l) = 0;
    end
end

X = P; % Return the sorted matrix