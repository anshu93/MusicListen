%Function to find time and frequency of a given peak
%Values.m

function[time, frequency] = Values(r, c, F, T)

tgradient = T(2)-T(1);
fgradient = F(2)-F(1);

if r==0 && c==0
    time = T(1);
    frequency = F(1);
elseif r==0 && c~=0
    frequency = F(1);
    time = (tgradient * (c-1)) +T(1);
elseif c==0 && r~=0
    time = T(1);
    frequency = (fgradient * (r-1))+F(1);
else
    time = (tgradient * (c-1))+T(1);
    frequency = (fgradient * (r-1))+F(1);
end

end