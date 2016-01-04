function [score] = deComposer(audioVector, beatsPerSecond)
% DECOMPOSER turns an audio vector into the score that created it
% Input: An audio vector and the time given in beats per second
% Output: The character string score in the format 'c.e.g-c-a-b'
% 


% Divide the sample into individual beats
samplesPerBeat = 8000/beatsPerSecond;
beatsInSong = length(audioVector) / samplesPerBeat;

% Store the beats in an array with the dimensions:
% number of rows = number of beats in song
% number of columns = sample size of each beat
beats = reshape(audioVector,samplesPerBeat,beatsInSong)';

if beatsPerSecond > 4
    warning('Too many beats per second can lead to sampling error. Results may be inaccurate.');
end

% For every beat, perform a spectral analysis to find the frequencies of
% that note/chord. Then write those notes/chords to a string.
for ii=1:beatsInSong
    % Find the spectrum/peaks/frequencies
    [freq,amp,cosineSpectrum,sineSpectrum] = spectrum(beats(ii,:));
    frequencyVector = peaks(freq,amp);
    % For every frequency in the vector, find the note
    for jj=1:length(frequencyVector)
        if jj ~= 1
            lastNote = currentNote;
            currentNote = frequencyToLetter(frequencyVector(jj));
            % This string compare removes duplicate notes in a chord
            if ~(strcmp(currentNote,lastNote))
                singleNote = [singleNote '.' frequencyToLetter(frequencyVector(jj))];
            end
        else
            currentNote = frequencyToLetter(frequencyVector(jj));
            singleNote = [currentNote];
        end
    end
    if ii ~= 1
        score = [score '-' singleNote];
    else
        score = singleNote;
    end
end

return
