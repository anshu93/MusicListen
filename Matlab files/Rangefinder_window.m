%Rangefinder_window.m
%Anshuman Prasad
%13th November, 2012

%% Define function
function [RwindowL,RwindowU,CwindowL,CwindowU] = Rangefinder_window(row,cols,r,c,deltaf,DeltaTimeL,DeltaTimeU)

%This function will deal with fence post errors etc and return values
%across which the window should span for a given peak

%% If no edge cases


RwindowL = r - deltaf;
RwindowU = r + deltaf;
CwindowL = c + DeltaTimeL;
CwindowU = c + DeltaTimeU;

%% Deal with fencepost errors in frequency (Rows)

if (r<=deltaf) %window spreads higher than top row of P
RwindowL = 1;
RwindowU = r + deltaf;
end

if (r+deltaf > row) %window spreads lower than bottom row of P
RwindowL = r-deltaf;
RwindowU = row;
end

%% Deal with fencepost errors in time (columns)

if (c + DeltaTimeU > cols) %window spreads farther right than rightmost column of P
   CwindowL = c + DeltaTimeL;
   CwindowU = cols;
end
