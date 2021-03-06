function Hd = lowpassfir
%LOWPASSFIR Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 8.3 and the Signal Processing Toolbox 6.21.
% Generated on: 26-Jan-2015 10:56:03

% FIR Window Lowpass filter designed using the FIR1 function.

% All frequency values are in Hz.
Fs = 50;  % Sampling Frequency

N    = 40;       % Order
Fc   = 1;       % Cutoff Frequency
flag = 'scale';  % Sampling Flag

% Create the window vector for the design algorithm.
win = hamming(N+1);

% Calculate the coefficients using the FIR1 function.
b  = fir1(N, Fc/(Fs/2), 'low', win, flag);
Hd = dfilt.dffir(b);

% [EOF]
