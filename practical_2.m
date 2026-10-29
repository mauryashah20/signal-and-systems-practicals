clc;
clear;
close all;

% Time vector
t = -5:0.01:5;

% Basic signals
u = t >= 0;
r = t .* (t >= 0);
sgn = sign(t);

% Discrete impulse
n = -5:5;
delta = (n == 0);

% Basic signals plot
figure('Color', 'w');

subplot(2, 2, 1);
stem(n, delta, 'k', 'filled');
grid on;
title('Unit Impulse \delta[n]');
xlabel('n');
ylabel('Amplitude');

subplot(2, 2, 2);
plot(t, u, 'k', 'LineWidth', 1.5);
grid on;
ylim([-0.2 1.2]);
title('Unit Step u(t)');
xlabel('t (s)');
ylabel('Amplitude');

subplot(2, 2, 3);
plot(t, r, 'k', 'LineWidth', 1.5);
grid on;
title('Unit Ramp r(t)');
xlabel('t (s)');
ylabel('Amplitude');

subplot(2, 2, 4);
plot(t, sgn, 'k', 'LineWidth', 1.5);
grid on;
ylim([-1.2 1.2]);
title('Signum sgn(t)');
xlabel('t (s)');
ylabel('Amplitude');

% Transformations
u_delayed = (t - 2) >= 0;
u_advanced = (t + 2) >= 0;
r_scaled1 = 2*t .* (2*t >= 0);
r_scaled2 = 0.5*t .* (0.5*t >= 0);
sgn_rev = sign(-t);
y_comp = u_delayed + 0.5 * r;

% Signal transformations plot
figure('Color', 'w');

subplot(2, 2, 1);
plot(t, u_delayed, 'k--', 'LineWidth', 1.5); hold on;
plot(t, u_advanced, 'k:', 'LineWidth', 1.5);
grid on;
title('Time Shifting: u(t-2) and u(t+2)');
xlabel('t (s)');
ylabel('Amplitude');
legend('u(t-2)', 'u(t+2)', 'Location', 'northwest');

subplot(2, 2, 2);
plot(t, r_scaled1, 'k--', 'LineWidth', 1.5); hold on;
plot(t, r_scaled2, 'k:', 'LineWidth', 1.5);
grid on;
title('Time Scaling: r(2t) and r(0.5t)');
xlabel('t (s)');
ylabel('Amplitude');
legend('r(2t)', 'r(0.5t)', 'Location', 'northwest');

subplot(2, 2, 3);
plot(t, sgn, 'k--', 'LineWidth', 1.5); hold on;
plot(t, sgn_rev, 'k:', 'LineWidth', 1.5);
grid on;
ylim([-1.3 1.3]);
title('Time Reversal: sgn(t) vs sgn(-t)');
xlabel('t (s)');
ylabel('Amplitude');
legend('sgn(t)', 'sgn(-t)', 'Location', 'northeast');

subplot(2, 2, 4);
plot(t, y_comp, 'k', 'LineWidth', 1.5);
grid on;
title('Composite: y(t) = u(t-2) + 0.5r(t)');
xlabel('t (s)');
ylabel('Amplitude');
