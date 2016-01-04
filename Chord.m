function [ chordVector ] = Chord(seconds, vectorFrequencies)
%CHORD takes notes that are in a beat and sums up the pure tones

%   The inputs are the number of seconds that are in the beat and the vector
%frequencies of all the notes in the beat. The output is a vector that
%simply adds up the sound vectors of all of the individual notes.


if numel(vectorFrequencies) > 4
    disp('Warning, this will only take the first four frequencies!')
else
end


g = zeros(1,8000 * seconds);
if numel(vectorFrequencies) >= 4
    for ii = 1:4
        h = PureTone(seconds,vectorFrequencies(ii));
        g = g + h;
    end
else
    for ii = 1:numel(vectorFrequencies)
        h = PureTone(seconds,vectorFrequencies(ii));
        g = g + h;
    end
end

if numel(vectorFrequencies) <= 4
    chordVector = g / numel(vectorFrequencies);
else
    chordVector = g / 4;
end



end

