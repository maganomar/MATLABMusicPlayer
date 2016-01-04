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