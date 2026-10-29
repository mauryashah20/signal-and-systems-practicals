clc;
clear;
close all;

% Parameters
N = 128;
N_fft = 256;

% Input signals (two rectangular pulses)
x1 = zeros(1, N);
x1(20:50) = 1;

x2 = zeros(1, N);
x2(20:50) = 1;

% 1. Direct Time-Domain Convolution
y_time = conv(x1, x2);

% 2. Frequency-Domain Multiplication via FFT
X1 = fft(x1, N_fft);
X2 = fft(x2, N_fft);
Y_freq = X1 .* X2;
y_freq = real(ifft(Y_freq));

% Truncate to match linear convolution length
L = length(y_time);
err = max(abs(y_time - y_freq(1:L)));
disp(['Max error between time convolution and FFT product: ', num2str(err)]);

% Frequency axis for plotting
f = (0:N_fft-1) / N_fft;

% Plotting
figure('Color', 'w');

subplot(3, 1, 1);
plot(x1, 'k-', 'LineWidth', 1.5); hold on;
plot(x2, 'k--', 'LineWidth', 1.5);
grid on;
title('Input Signals x_1[n] and x_2[n]');
xlabel('n');
ylabel('Amplitude');
legend('x_1[n]', 'x_2[n]', 'Location', 'northeast');

subplot(3, 1, 2);
plot(f, abs(X1), 'k--', 'LineWidth', 1.2); hold on;
plot(f, abs(X2), 'k:', 'LineWidth', 1.2);
plot(f, abs(Y_freq), 'k-', 'LineWidth', 1.5);
grid on;
title('Frequency Spectra: |X_1(f)|, |X_2(f)|, and Product |Y(f)|');
xlabel('Normalized Frequency');
ylabel('Magnitude');
legend('|X_1|', '|X_2|', '|Y| = |X_1 \cdot X_2|', 'Location', 'northeast');

subplot(3, 1, 3);
plot(y_time, 'k-', 'LineWidth', 1.5); hold on;
plot(y_freq(1:L), 'ko', 'MarkerSize', 4);
grid on;
title('Verification: Time Convolution vs IFFT(X_1 \cdot X_2)');
xlabel('n');
ylabel('Amplitude');
legend('Time Conv', 'IFFT Product', 'Location', 'northeast');
