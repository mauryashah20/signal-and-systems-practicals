%% =========================================================================
% EXPERIMENT NO. 7
% AIM: To Study the Fourier series of Square, Sawtooth and Triangular waves using MATLAB/Scilab.
% =========================================================================

clc;
clear all;
close all;

% Parameters matching syllabus
T = 2*pi;
omega = 2*pi/T;
t = linspace(0, 4*pi, 1000);
N = 100; % Number of harmonics

% -------------------------------------------------------------------------
% 1. Rectangular / Square Wave Fourier Series (matching peer's file)
% -------------------------------------------------------------------------
sq_wave = zeros(size(t));
for n = 1:2:N
    sq_wave = sq_wave + (4 / (n * pi)) * sin(n * omega * t);
end

figure('Name', 'Experiment 7 - Rectangular Wave Fourier Series', 'NumberTitle', 'off', 'Color', 'w');
plot(t, sq_wave, 'LineWidth', 1.5);
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title("fourier series rectangular wave");

% -------------------------------------------------------------------------
% 2. All Three Waveforms (Square, Sawtooth, Triangular) as in Aim
% -------------------------------------------------------------------------
% Sawtooth Wave Fourier Series
saw_wave = zeros(size(t));
for n = 1:N
    saw_wave = saw_wave + (2 / (n * pi)) * ((-1)^(n+1)) * sin(n * omega * t);
end

% Triangular Wave Fourier Series
tri_wave = zeros(size(t));
for n = 1:2:N
    tri_wave = tri_wave + (8 / (pi^2 * n^2)) * ((-1)^((n-1)/2)) * sin(n * omega * t);
end

figure('Name', 'Experiment 7 - Square, Sawtooth & Triangular Waves', 'NumberTitle', 'off', 'Color', 'w');

subplot(3, 1, 1);
plot(t, sq_wave, 'b-', 'LineWidth', 1.5);
grid on;
title('Fourier Series: Square Wave');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(3, 1, 2);
plot(t, saw_wave, 'r-', 'LineWidth', 1.5);
grid on;
title('Fourier Series: Sawtooth Wave');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(3, 1, 3);
plot(t, tri_wave, 'k-', 'LineWidth', 1.5);
grid on;
title('Fourier Series: Triangular Wave');
xlabel('Time (s)'); ylabel('Amplitude');