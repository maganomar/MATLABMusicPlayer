% Magan Omar
% Section 20
% I worked with Ariana Vidana, Fernanda Arreola, Michelle, Victor Lopez,
% Rene Romo, Aliyah Lee, Julius Tucker, Magan Omar, Brent Williams

function [ frequencyVector ] = peaks( freq,amp )
%PEAKS takes the max value of the amplitude, and makes a new vector
%inputing all of the values in amp and puts it into frequencyVector.
%   The inputs are the freq and amp vectors. The output is the newly made
%   frequencyVector vector.
    

f = max(amp);
[o p] = size(amp)
frequencyVector = []
for index = 1:p
    if amp(1,n) < f/2
        frequencyVector = [frequencyVector amp(1,p)]
    else
    end
end


end



function [ freq,amp,cosWeights,sinWeights ] = spectrum(beatVector)
%SPEC computes the spectrum of a signal.
%   The input is the spectrum of the signal, and the outputs are the cosine part of x and the
%   sine part of y, and the calculated frequency and amplitude vectors,
%   that use the values x and y.

narginchk(1,1)
N = length(beatVector);
if mod(N,2) == 0
M = N / 2;
else
error('Signal length is not even.\n');
end
% Initialize the vectors x and y.
cosWeights = zeros(M+1,1);
sinWeights = cosWeights;
% The first element x0 of the vector x is just the mean of s.
% The first element y0 of the vector y is zero by convention.
cosWeights(1) = mean(beatVector);
% Generate vector t so that Cm = cos(m*t) and Sm = sin(m*t).
t = 2*pi*(0:(N-1))/N;
% Find xm and ym for 0 < m < N/2.
for m = 1:((N-1)/2)
cosWeights(m+1) = 2*dot(cos(m*t), beatVector)/N;
sinWeights(m+1) = 2*dot(sin(m*t), beatVector)/N;
end
% If N is even, find xm for m=M (ym=0 for m=M by convention).
if 2*M == N
cosWeights(M+1) = dot(cos(M*t), beatVector)/N;
end
freq = (0:fix(N/2))*8000/N
amp = sqrt(cosWeights.^2 + sinWeights.^2)
bar(freq,amp);

end



% Exercises:
% 
% 1. The plot is just one straight line at the frequency at 440, because the input is just a pure tone at
%    the frequency of 440.
%    
% 2. We found the signal using the cosine function, and the sine function is not
%    audible.
%    
% 3. the note 'c0,4' is leaking. The note spreads farther due to leakage.
% 
% 4. Yes, the two scores match. Yes, they sound the same. You can compare them by 
%    looking at them in MATLAM. The corresponding elements are the same.