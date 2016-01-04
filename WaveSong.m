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

