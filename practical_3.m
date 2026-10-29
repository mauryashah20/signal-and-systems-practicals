clc;
clear;
close all;

% Time vector
t = -2:0.005:2;

% (i) Sine and Cosine signals
f0 = 1;
x_sin = sin(2*pi*f0*t);
x_cos = cos(2*pi*f0*t);

% (ii) Sinc function
x_sinc = zeros(size(t));
idx_nz = (t ~= 0);
x_sinc(idx_nz) = sin(pi*t(idx_nz)) ./ (pi*t(idx_nz));
x_sinc(t == 0) = 1;

% (iii) Triangular waveform
T = 1;
tau = t/T - floor(t/T + 0.5);
x_tri = 2 * abs(2 * tau) - 1;

% (iv) Rectangular pulse
x_rect = double(abs(t) <= 0.5);

% (v) Sawtooth waveform
x_saw = 2 * (t/T - floor(t/T + 0.5));

% (vi) Exponential signals
x_exp_decay = exp(-t) .* (t >= 0);
x_exp_rise  = exp(0.5*t) .* (t >= 0);

% Plotting all 6 waveforms
figure('Color', 'w');

subplot(3, 2, 1);
plot(t, x_sin, 'k-', 'LineWidth', 1.5); hold on;
plot(t, x_cos, 'k--', 'LineWidth', 1.5);
grid on;
title('Sine & Cosine Signals (f_0 = 1 Hz)');
xlabel('Time (s)');
ylabel('Amplitude');
legend('sin(2\pi t)', 'cos(2\pi t)', 'Location', 'northeast');

subplot(3, 2, 2);
plot(t, x_sinc, 'k', 'LineWidth', 1.5);
grid on;
title('Sinc Function: sin(\pi t) / (\pi t)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 2, 3);
plot(t, x_tri, 'k', 'LineWidth', 1.5);
grid on;
ylim([-1.2 1.2]);
title('Triangular Waveform (T = 1 s)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 2, 4);
plot(t, x_rect, 'k', 'LineWidth', 1.5);
grid on;
ylim([-0.2 1.2]);
title('Rectangular Pulse (Width = 1 s)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 2, 5);
plot(t, x_saw, 'k', 'LineWidth', 1.5);
grid on;
ylim([-1.2 1.2]);
title('Sawtooth Waveform (T = 1 s)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 2, 6);
plot(t, x_exp_decay, 'k-', 'LineWidth', 1.5); hold on;
plot(t, x_exp_rise, 'k--', 'LineWidth', 1.5);
grid on;
title('Exponential Signals');
xlabel('Time (s)');
ylabel('Amplitude');
legend('e^{-t}', 'e^{0.5t}', 'Location', 'northwest');
