%% =========================================================================
% EXPERIMENT NO. 1
% AIM: To study the MATLAB environment and familiarize with basic MATLAB
%      commands used for signal generation, manipulation, visualization,
%      and system analysis.
% =========================================================================
clc;
clear;
close all;

% Simple arithmetic operations
a = 10;
b = 5;

disp("addition=" + string(a+b));
disp("subtraction=" + string(a-b));
disp("multiplication=" + string(a*b));
disp("division=" + string(a/b));

% Continuous-time sine wave
t = 0:0.001:2*pi;
x = sin(t);

% Discrete-time cosine wave
w = 0:1:20;
y = cos(w);

% Plotting
figure('Name', 'Experiment 1: Basic Waveforms', 'Color', 'w');

subplot(2, 1, 1);
plot(t, x, 'b', 'LineWidth', 1.5);
grid on;
xlabel('time');
ylabel('amplitude');
title('continuous time sinewave');

subplot(2, 1, 2);
stem(w, y, 'r', 'filled');
grid on;
xlabel('time');
ylabel('amplitude');
title('discrete time cosine wave');