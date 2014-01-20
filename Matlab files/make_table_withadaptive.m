% make_table
%Shazam Project - ECE 280
%7th November, 2012
%Anshuman Prasad

% Read MP3
%[y,fs] = mp3read('viva.mp3');

%% Pre-processing
y = mean(y,2);
y = y - mean(y);
y = resample(y,8000,fs);

%% Spectrogram Generation
fs = 8000;
window = 0.064*fs;
noverlap = 0.032*fs;
nfft = window;
[S,F,T] = spectrogram(y,window,noverlap,nfft,fs);
S = abs(S); %Take absolute value of spectrogram
S = log10(S); % S that is used to work with

%% Plot Spectrogram
S = abs(S); % Remove negative signs because of log
figure(1); 
imagesc([min(T) max(T)],[min(F) max(F)],S); 
colorbar; 
colormap hot;
xlabel('Time');
ylabel('Frequency');
title('Log plot of magnitude of spectrogram vs time');

%% Finding local peaks
P = S; % Set final matrix equal to the log magnitude of S
for k = -4:4
    for j = -4:4
        if (j ~= 0 && k ~= 0) % Do not check peak with itself
        CS = circshift(S,[j,k]);
        Q = ((S-CS)>0); % Compute binary map for shift in question
        P = P .* Q; % Do elementwise multiplication to eliminate all non-peaks for this shift
        end
    end
end

peaks = nnz(P); % Number of peaks for particular gs value


%% Plotting Constellation map
figure(2);
imagesc([min(T) max(T)],[min(F) max(F)],P);
xlabel('Time');
ylabel('Frequency');
title('Plot of Spectrogram peaks with gs = 9');
colormap(1-gray);


P = Threshold(P,T); %Implement adaptive filter onto the matrix to ensure 30 second 

bigpeaks = nnz(P); %Number of peaks remaining

%% Plotting the constellation map

figure(3);
imagesc([min(T) max(T)],[min(F) max(F)],P);
xlabel('Time');
ylabel('Frequency');
title('Plot of highest peaks of the spectrogram');
colormap(1-gray);


%% Constructing the table
[row,cols] = size(P);
figure(4);
imagesc([min(T) max(T)],[min(F) max(F)],P);
xlabel('Time');
ylabel('Frequency');
title('Plot of highest peaks of the spectrogram showing connections between paired peaks');
colormap(1-gray);
hold on %hold on so that the lines can go on after

% move window across screen
fanout = 3;
DeltaTimeL = 5;
DeltaTimeU = 10;
deltaf = 5;

Table = [];
for r = 1:row 
    for c = 1:cols
        if(P(r,c) ~= 0) %If point is a peak
            tpoint = T(c);
            fpoint = F(r);
            PeaksInWindow = 0;
            % Find range for the window to span
            [RwindowL,RwindowU,CwindowL,CwindowU] = Rangefinder_window(row,cols,r,c,deltaf,DeltaTimeL,DeltaTimeU);
            
            for Rwindow = RwindowL: RwindowU
                for Cwindow = CwindowL: CwindowU
                if(P(Rwindow,Cwindow) ~= 0 && PeaksInWindow < fanout) %If found peak in window and need more peaks to reach fanout
                    t = T(Cwindow);
                    f = F(Rwindow);
                    NewRow = [fpoint f tpoint t-tpoint];
                    Table = [Table ; NewRow];
                    PeaksInWindow = PeaksInWindow + 1;
                    
                    %Stuff for plotting
                    hold on
                    plot([tpoint t],[fpoint f],'b-o');
                    
                end  
                end
            end
            
        end
    end
end
