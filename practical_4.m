clc;
clear;
close all;

% 1. Linearity Verification: T{x} = 4*x
x1 = [1 2 3];
x2 = [4 5 6];
a = 2; b = 3;
lhs = 4 * (a*x1 + b*x2);
rhs = a*(4*x1) + b*(4*x2);
disp('Linearity test (T{x} = 4x):');
disp(isequal(lhs, rhs));

% 2. Time-Invariance: y[n] = 2*x[n]
n = 0:5;
x = [1 2 3 4 5 6];
k = 2;
y_delayed = [zeros(1, k), 2*x(1:end-k)];
x_delayed = [zeros(1, k), x(1:end-k)];
delayed_y = 2 * x_delayed;
disp('Time Invariance test:');
disp(isequal(y_delayed, delayed_y));

% 3. BIBO Stability: h[n] = (0.5)^n
n_inf = 0:100;
h = (0.5).^n_inf;
sum_h = sum(abs(h));
disp('BIBO Stability (Sum of |h[n]|):');
disp(sum_h);

% 4. Energy and Power Calculation
x_en = [1, -1, 2, -2, 3];
E = sum(abs(x_en).^2);
disp('Energy of aperiodic signal (Joules):');
disp(E);

N_per = 16;
n_per = 0:N_per-1;
x_p = 2 * sin(2*pi*n_per / N_per);
P = (1 / N_per) * sum(abs(x_p).^2);
disp('Power of periodic signal (Watts):');
disp(P);

% 5. Even and Odd Decomposition
n_seq = -4:4;
x_sig = [1 2 3 4 5 0 0 0 0];
x_rev = fliplr(x_sig);
x_even = 0.5 * (x_sig + x_rev);
x_odd  = 0.5 * (x_sig - x_rev);

% Energy conservation verification
E_orig = sum(abs(x_sig).^2);
E_even = sum(abs(x_even).^2);
E_odd  = sum(abs(x_odd).^2);
disp('E_orig vs (E_even + E_odd):');
disp([E_orig, E_even + E_odd]);

% Plotting
figure('Color', 'w');

subplot(2, 2, 1);
stem(n_inf(1:15), h(1:15), 'k', 'filled');
grid on;
title('Stable Impulse Response: h[n] = (0.5)^n');
xlabel('n');
ylabel('h[n]');

subplot(2, 2, 2);
stem(n_seq, x_sig, 'k', 'filled');
grid on;
title('Original Signal x[n]');
xlabel('n');
ylabel('Amplitude');

subplot(2, 2, 3);
stem(n_seq, x_even, 'k', 'filled');
grid on;
title('Even Component x_e[n]');
xlabel('n');
ylabel('Amplitude');

subplot(2, 2, 4);
stem(n_seq, x_odd, 'k', 'filled');
grid on;
title('Odd Component x_o[n]');
xlabel('n');
ylabel('Amplitude');