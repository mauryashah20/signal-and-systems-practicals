%% =========================================================================
% EXPERIMENT NO. 6
% AIM: To study impz, filter and freqz properties of signal using MATLAB/Scilab.
% =========================================================================

clc;
clear all;
close all;

% System transfer function coefficients: H(z) = 1 / (1 - z^(-1))
b = [1];
a = [1 -1];
n = 0:1:10;

% -------------------------------------------------------------------------
% Figure 1: Impulse response using impz
% -------------------------------------------------------------------------
figure();
stem(n); hold on;
stem(impz(b, a, n));
title("using impz");

% -------------------------------------------------------------------------
% Figure 2: Response using filter and frequency response using freqz
% -------------------------------------------------------------------------
figure();

% Subplot 1: Filter response for input sequence n
subplot(1, 2, 1);
stem(n);
stem(filter(b, a, n));
title("using filter");

% Subplot 2: Frequency response using freqz
subplot(1, 2, 2);
stem(n);
stem(freqz(b, a, n));
title("using freqz");

%% =========================================================================
% LOCAL COMPATIBILITY FUNCTIONS
% These allow the code to run seamlessly on standard MATLAB installations
% with or without the Signal Processing Toolbox installed.
% =========================================================================

function h = impz(b, a, n)
    % Compute impulse response by filtering a discrete unit impulse delta[n]
    delta = [1, zeros(1, length(n) - 1)];
    h = filter(b, a, delta);
    h = h(:);
end

function [h, w] = freqz(b, a, w)
    % Compute frequency response H(e^jw) = B(e^jw) / A(e^jw) at frequencies w
    w = w(:).';
    ejw_num = exp(-1j * (0:length(b)-1)' * w);
    num = b(:).' * ejw_num;
    ejw_den = exp(-1j * (0:length(a)-1)' * w);
    den = a(:).' * ejw_den;
    h = (num ./ den).';
end
