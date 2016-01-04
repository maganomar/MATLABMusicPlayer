% Magan Omar
% Section 20
% I worked by myself

function [toneVector] = PureTone(seconds, frequency)
%PURETONE takes the frequency and number of seconds and produces a pure
%tone based off of those two factors. 

% The input is the number of seconds that the note is desired to play, and
% the frequency of the note, and the output is an audio sample vector that
% is the pure tone at the given frequency for the specified number of
% seconds.



t = 0:(seconds * 8000-1);
toneVector = cos(2*pi*frequency*t/8000);


end


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




function [ audioVector ] = WaveSong( songVector, time )
%WAVESONG Gives out an audio wave vector with the input of all the beats in
%the song
%   The input is a cell array of the frequencies of all of the beats in the
%   song, as well as beats per second, and the output is the audio wave
%   vector that is the result of this.



for ii = 1:numel(songVector)
    
    beatFreq = songVector{ii};
    
    x{ii} = Chord(1/time,beatFreq);
    
    
    audioVector = horzcat(x{1:ii});


end
    
    

end





function [ soundVector ] = MusicMan( score,time )
%MusicMan 
%   


narginchk(1,2)

if nargin == 0
    disp('Please input score and time!')
elseif nargin == 1
    time = 4;
end







function [songFrequencies] = SongParser(score)
% SONGPARSER turns human-readable music into a cell array of frequencies
% Input: An appropriately written score
% Output: A cell-array of frequency vectors corresponding to each beat
%
% The form of the input is 'a-b.c.d-e' where the -'s separate beats, and
% the .'s separate notes in a chord. This example is three beats: the pure
% A note, then a chord of B, C, and D played together, and finally the pure
% note E.
%
% This parser will handle more details than simple notes:
% It will handle c0-c1-c2 as low C, middle C, high C.
% It will actually handle d-ds-dl for D, D-sharp, D-flat.
% It will accept 3c as three consecutive C notes.

% Split the score up into beats
allNotes = regexp(score,'\-','split');
beatCounter = 1;

% For each beat
for ii = 1:length(allNotes)
    songBeat = [];
    chord = allNotes{ii};
    % Split the beat up into notes
    allTones = regexp(chord,'\.','split');
    for jj = 1:length(allTones)
        singleTone = allTones{jj};
        % Find the length of the note, octave and modifier (sharp or not)
        nums = regexpi(singleTone,'[a-z]','split');
        if jj == 1
            [number, status] = str2num(nums{1});
            if status
                beats = number;
            else
                beats = 1;
            end
            if beats == 0
                break;
            end
        end
        [number, status] = str2num(nums{end});
        if status && (number <= 2)
            octave = number;
        else
            octave = 1;
        end
        notes = regexp(singleTone,'[0-9]','split');
        kk = 1;
        while 1
            if ~isempty(notes{kk})
                singleNote = notes{kk};
                break;
            else
                kk = kk+1;
            end
            if kk > 10
                fprintf('Chord: %s\n Tone: %s\n Key: %s\n',chord, singleTone, key);
                error('Could not find a note');
            end
        end
        if (regexpi(singleNote(1),'[a-g]'))
            key = singleNote(1);
        elseif (regexpi(singleNote(1),'p'))
            key = 'p';
        else
            fprintf('Chord: %s\n Tone: %s\n Key: %s\n',chord, singleTone, key);
            error('Unknown key');
        end
        mod = 'n';
        if length(singleNote) == 2
            if (regexpi(singleNote(2),'[l s n]'))
                mod = singleNote(2);
            else 
                fprintf('Chord: %s\n Tone: %s\n Modifier: %s\n',chord, singleTone, singleNote(2));
                warning('Unknown modifier. Accepted modifiers are l (flat), s (sharp) and n (neutral)')
            end
        end
        
        %%%%% Normally I would put this by itself in a file
        letter = lower(key);
        frequency = 0;

        if strcmp(mod,'l')  % This is for flats. They are not mentioned in the writeup
            switch letter
            case {'c'}
                frequency = 247.5;
            case {'d'}
                frequency = 277;
            case {'e'}
                frequency = 311;
            case {'f'}
                frequency = 330;
            case {'g'}
                frequency = 370;
            case {'a'}
                frequency = 415;
            case {'b'}
                frequency = 466;
            otherwise
                disp('Error');
            end
        elseif strcmp(mod,'s')
            switch letter
            case {'c'}
                frequency = 277;
            case {'d'}
                frequency = 311;
            case {'e'}
                frequency = 349;
            case {'f'}
                frequency = 370;
            case {'g'}
                frequency = 415;
            case {'a'}
                frequency = 466;
            case {'b'}
                frequency = 554;
            otherwise
                disp('Error');
            end
        else
            switch letter
                case {'c'}
                    frequency = 262;
                case {'d'}
                    frequency = 294;
                case {'e'}
                    frequency = 330;
                case {'f'}
                    frequency = 349;
                case {'g'}
                    frequency = 392;
                case {'a'}
                    frequency = 440;
                case {'b'}
                    frequency = 495;
                case {'p'}
                    frequency = 0;
                otherwise
                    disp('Error');
            end
        end

        if octave == 2
            frequency = frequency * 2;
        elseif octave == 0
            frequency = frequency / 2;
        end

        songBeat(jj) = frequency;
        
    end
    if beats ~= 0
        for kk=1:beats;
            songFrequencies{beatCounter} = songBeat;
            beatCounter = beatCounter + 1;
        end
    end
end

return

end






function [toneVector] = PureTone(seconds, frequency)
%PURETONE takes the frequency and number of seconds and produces a pure
%tone based off of those two factors. 

% The input is the number of seconds that the note is desired to play, and
% the frequency of the note, and the output is an audio sample vector that
% is the pure tone at the given frequency for the specified number of
% seconds.



t = 0:(seconds * 8000-1);
toneVector = cos(2*pi*frequency*t/8000);


end







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

function [ audioVector ] = WaveSong( songVector, time )
%WAVESONG Gives out an audio wave vector with the input of all the beats in
%the song
%   The input is a cell array of the frequencies of all of the beats in the
%   song, as well as beats per second, and the output is the audio wave
%   vector that is the result of this.



for ii = 1:numel(songVector)
    
    beatFreq = songVector{ii};
    
    x{ii} = Chord(1/time,beatFreq);
    
    
    audioVector = horzcat(x{1:ii});


end
    
    

end

sound(WaveSong(SongParser(score),2),8000)
end



% Exercises


% 3. The square wave makes the sound much more distorted than the original 
%     pure function. 
%     
% 4. For the amplitude, for the new function, just multiply it by a scalar,
%    which raises the volume.
% 5. The tempo, which is the number of beats per second, is different. It has 
%    increased between the two songs. 