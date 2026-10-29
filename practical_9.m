clc;
clear;
close all;

% 1. Auto-correlation of a periodic sinusoid
N = 100;
n = 0:N-1;
f0 = 0.05;
x_per = sin(2*pi*f0*n);

% Compute auto-correlation using conv(x, fliplr(x))
r_xx = conv(x_per, fliplr(x_per));
lags_xx = -(N-1):(N-1);

% 2. Cross-correlation and Time Delay Estimation
delay = 15;
y_delayed = [zeros(1, delay), x_per(1:end-delay)];
r_xy = conv(y_delayed, fliplr(x_per));
lags_xy = -(N-1):(N-1);

% Find peak lag for delay estimation
[~, max_idx] = max(r_xy);
est_delay = lags_xy(max_idx);
disp(['Injected delay: ', num2str(delay)]);
disp(['Estimated delay from cross-correlation peak: ', num2str(est_delay)]);

% 3. Auto-correlation of aperiodic decaying exponential
x_exp = (0.85).^n;
r_exp = conv(x_exp, fliplr(x_exp));

% 4. Effect of noise on auto-correlation
noise = 0.5 * randn(size(x_per));
x_noisy = x_per + noise;
r_noisy = conv(x_noisy, fliplr(x_noisy));

% Figure 1: Correlation of Signals
figure('Color', 'w');

subplot(3, 1, 1);
stem(lags_xx, r_xx, 'k', 'MarkerSize', 3);
grid on;
title('Auto-correlation of Sinusoid r_{xx}[l]');
xlabel('Lag (l)');
ylabel('Amplitude');

subplot(3, 1, 2);
stem(lags_xy, r_xy, 'k', 'MarkerSize', 3);
grid on;
title(['Cross-correlation r_{xy}[l] (Peak at Lag = ', num2str(est_delay), ')']);
xlabel('Lag (l)');
ylabel('Amplitude');

subplot(3, 1, 3);
stem(lags_xx, r_exp, 'k', 'MarkerSize', 3);
grid on;
title('Auto-correlation of Decaying Exponential');
xlabel('Lag (l)');
ylabel('Amplitude');

% Figure 2: Noise Robustness & Symmetry
figure('Color', 'w');

subplot(2, 1, 1);
stem(lags_xx, r_noisy, 'k', 'MarkerSize', 3);
grid on;
title('Auto-correlation of Noisy Sinusoid');
xlabel('Lag (l)');
ylabel('Amplitude');

subplot(2, 1, 2);
diff_sym = max(abs(r_xx - fliplr(r_xx)));
disp(['Symmetry error (|r_xx[l] - r_xx[-l]|): ', num2str(diff_sym)]);
plot(lags_xx, r_xx, 'k-', 'LineWidth', 1.5);
grid on;
title('Symmetry of Auto-correlation: r_{xx}[-l] = r_{xx}[l]');
xlabel('Lag (l)');
ylabel('Amplitude');
