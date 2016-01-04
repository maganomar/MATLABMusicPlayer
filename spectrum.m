function [ freq,amp,cosWeights,sinWeights ] = spectrum(beatVector)
%SPEC computes the spectrum of a signal
%   The input is the spectrum of the signal, and the output is the cosine part of x and the
%   sine part of y.

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



% function [x,y] = spec(s)
% % SPEC Compute the spectrum of a signal.
% % [x,y] = spec(s) returns the cos part x and the sin part y
% % of the spectrum of the signal s.
% % Confirm one argument of even length.
% 
% Figure 7