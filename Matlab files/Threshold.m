%% Thresholding function
%% Anshuman Prasad

function[B] = Threshold(P,T) %Function takes in the matrix and time vector
A = []; %Matrix
B = []; %Final result
Tconsidered = 0;
if max(T) < 1 %If clip less than one second
    A = [max(T)];
else
   NumberOfElements = 0; %How many columns correspond to a second?
   
   while NumberOfElements ~= length(T)
       
       Tlast = T(NumberOfElements+1);
    while Tconsidered <= Tlast + 1 && NumberOfElements ~= length(T)
    NumberOfElements = NumberOfElements +1;
    Tconsidered = T(NumberOfElements);
    end
   A = [A NumberOfElements]; %This vector has the elements of the time vector that correspond to the one second chunks. Eg. [5 7 9] means
                            %the first 5 elements make 1s, next 2 make the next etc.
   end                     
end

%% Thresholding second by second

for chunks = 1:length(A)
    if chunks == 1
        SecondMatrix = P(:,1:A(chunks));
        SortMatrix = Threshmagfinder(SecondMatrix,T(A(chunks)));
        B = [B SortMatrix];
    else
        SecondMatrix = P(:,A(chunks-1)+1:A(chunks));
        SortMatrix = Threshmagfinder(SecondMatrix, T(A(chunks))- T(A(chunks-1)));
        B = [B SortMatrix];
    end
end