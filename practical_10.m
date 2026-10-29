% Clear the workspace, close figures, and clear the command window.
clear;
close all;
clc;

% Define the input signal and its time indices.
x = [1, 1, 1, 1, 1];
nx = 0:4;
Lx = length(x);

% Define the impulse response of the system.
Lh = 20;
nh = 0:(Lh - 1);
h = (0.5) .^ nh;

% Initialize output parameters for linear convolution.
Ly = Lx + Lh - 1;
ny = 0:(Ly - 1);
y_direct = zeros(1, Ly);

% Compute the convolution directly using nested summations.
for n_idx = 1:Ly
    n = n_idx - 1;
    sum_val = 0;
    for k_idx = 1:Lx
        k = k_idx - 1;
        lag = n - k;
        if (lag >= 0) && (lag < Lh)
            sum_val = sum_val + x(k_idx) * h(lag + 1);
        end
    end
    y_direct(n_idx) = sum_val;
end

% Compute the output using MATLAB's convolution function.
y_conv = conv(x, h);

% Define numerator and denominator coefficients for the input and system.
B_h = 1;
A_h = [1, -0.5];
B_x = [1, 1, 1, 1, 1];
A_x = 1;

% Combine the input and system transfer functions.
B_y = conv(B_x, B_h);
A_y = conv(A_x, A_h);

% Compute the output using the inverse Z-transform representation.
delta = zeros(1, Ly);
delta(1) = 1;
y_z = filter(B_y, A_y, delta);

% Define the desired finite-duration output.
N_design = 15;
d = zeros(1, N_design);
d(1) = 1;

% Construct the lower-triangular convolution matrix.
H_mat = zeros(N_design, N_design);
for r = 1:N_design
    for c = 1:r
        H_mat(r, c) = h(r - c + 1);
    end
end

% Solve for the input that produces the desired output.
x_des = (H_mat \ d')';
y_actual = conv(x_des, h);
y_eval = y_actual(1:N_design);
err_sig = y_eval - d;
mse = mean(err_sig .^ 2);
max_err = max(abs(err_sig));

% Compute the finite-duration step response.
N_step = 25;
n_step = 0:(N_step - 1);
u = ones(1, N_step);
s_full = conv(u, h);
s = s_full(1:N_step);
y_ss = 2.0;

% Create the first figure and configure its appearance.
fig1 = figure(1);
set(fig1, 'Color', 'w');

% Plot the input signal.
subplot(3, 2, 1);
stem(nx, x, 'filled', 'Color', [0.12, 0.53, 0.90], 'LineWidth', 1.8); grid on;
set(gca, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'GridColor', [0.8, 0.8, 0.8]);
title('Input x[n]', 'Color', 'k', 'FontWeight', 'bold');
xlabel('n', 'Color', 'k'); ylabel('x[n]', 'Color', 'k');

% Plot the impulse response.
subplot(3, 2, 2);
stem(nh, h, 'filled', 'Color', [0.18, 0.49, 0.20], 'LineWidth', 1.6); grid on;
set(gca, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'GridColor', [0.8, 0.8, 0.8]);
title('Impulse Response h[n]', 'Color', 'k', 'FontWeight', 'bold');
xlabel('n', 'Color', 'k'); ylabel('h[n]', 'Color', 'k');

% Plot the direct convolution output.
subplot(3, 2, 3);
stem(ny, y_direct, 'filled', 'Color', [0.83, 0.18, 0.18], 'LineWidth', 1.6); grid on;
set(gca, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'GridColor', [0.8, 0.8, 0.8]);
title('Direct Convolution y[n]', 'Color', 'k', 'FontWeight', 'bold');
xlabel('n', 'Color', 'k'); ylabel('y[n]', 'Color', 'k');

% Plot the Z-transform inverse output.
subplot(3, 2, 4);
stem(ny, y_z, 'filled', 'Color', [0.48, 0.12, 0.64], 'LineWidth', 1.6); grid on;
set(gca, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'GridColor', [0.8, 0.8, 0.8]);
title('Z-Transform Inverse y[n]', 'Color', 'k', 'FontWeight', 'bold');
xlabel('n', 'Color', 'k'); ylabel('y[n]', 'Color', 'k');

% Plot the difference between the two convolution methods.
subplot(3, 2, [5, 6]);
stem(ny, y_direct - y_z, 'filled', 'Color', [0.90, 0.32, 0.00], 'LineWidth', 1.6); grid on;
set(gca, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'GridColor', [0.8, 0.8, 0.8]);
title('Difference (Direct - Z-Transform)', 'Color', 'k', 'FontWeight', 'bold');
xlabel('n', 'Color', 'k'); ylabel('Error', 'Color', 'k');

% Create the second figure and configure its appearance.
fig2 = figure(2);
set(fig2, 'Color', 'w');

% Plot the designed input signal.
subplot(2, 2, 1);
stem(0:(length(x_des)-1), x_des, 'filled', 'Color', [0.0, 0.54, 0.48], 'LineWidth', 1.8); grid on;
set(gca, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'GridColor', [0.8, 0.8, 0.8]);
title('Designed Input x[n]', 'Color', 'k', 'FontWeight', 'bold');
xlabel('n', 'Color', 'k'); ylabel('x[n]', 'Color', 'k');

% Compare the desired and actual inverse-filter outputs.
subplot(2, 2, 2);
stem(0:(N_design-1), d, 'k', 'LineWidth', 2.0); hold on;
stem(0:(N_design-1), y_eval, '--', 'filled', 'Color', [0.91, 0.12, 0.39], 'LineWidth', 1.6); hold off;
grid on; legend('Desired d[n]', 'Actual y[n]', 'TextColor', 'k');
set(gca, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'GridColor', [0.8, 0.8, 0.8]);
title('Inverse Filter Output', 'Color', 'k', 'FontWeight', 'bold');
xlabel('n', 'Color', 'k'); ylabel('y[n]', 'Color', 'k');

% Plot the deconvolution error.
subplot(2, 2, 3);
stem(0:(N_design-1), err_sig, 'filled', 'Color', [1.0, 0.43, 0.0], 'LineWidth', 1.6); grid on;
set(gca, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'GridColor', [0.8, 0.8, 0.8]);
title('Deconvolution Error e[n]', 'Color', 'k', 'FontWeight', 'bold');
xlabel('n', 'Color', 'k'); ylabel('e[n]', 'Color', 'k');

% Plot the step response and its steady-state value.
subplot(2, 2, 4);
stem(n_step, s, 'filled', 'Color', [0.08, 0.40, 0.75], 'LineWidth', 1.6); hold on;
yline(y_ss, 'r--', 'Steady-State = 2.0', 'LineWidth', 2.0); hold off;
grid on; set(gca, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'GridColor', [0.8, 0.8, 0.8]);
title('Step Response Steady-State', 'Color', 'k', 'FontWeight', 'bold');
xlabel('n', 'Color', 'k'); ylabel('s[n]', 'Color', 'k');

% Display the simulation results and error metrics.
disp('--- Simulation Completed Successfully ---');
disp('Part (a) First 5 samples:');
disp(y_direct(1:5));
disp('Part (b) First 5 samples:');
disp(y_z(1:5));
disp('Designed Input x[n]:');
disp(x_des(1:5));
fprintf('MSE Error: %e\n', mse);
fprintf('Steady-State Output: %f\n', s(end));
