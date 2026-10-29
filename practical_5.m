clc;
clear;
close all;

% Input sequences
rect = ones(1, 10);
tri = [1:5, 5:-1:1] / 5;

% Case (i): Rectangular * Rectangular
y_rect_rect = custom_conv(rect, rect);

% Case (ii): Rectangular * Triangular
y_rect_tri = custom_conv(rect, tri);

% Case (iii): Triangular * Triangular
y_tri_tri = custom_conv(tri, tri);

% Verification using built-in conv
err1 = max(abs(y_rect_rect - conv(rect, rect)));
err2 = max(abs(y_rect_tri - conv(rect, tri)));
err3 = max(abs(y_tri_tri - conv(tri, tri)));
disp('Max errors vs built-in conv:');
disp([err1, err2, err3]);

% Plotting
figure('Color', 'w');

subplot(3, 1, 1);
stem(0:length(y_rect_rect)-1, y_rect_rect, 'k', 'filled');
grid on;
title('Case (i): Rectangular * Rectangular (Triangular Output)');
xlabel('n');
ylabel('Amplitude');

subplot(3, 1, 2);
stem(0:length(y_rect_tri)-1, y_rect_tri, 'k', 'filled');
grid on;
title('Case (ii): Rectangular * Triangular (Parabolic Output)');
xlabel('n');
ylabel('Amplitude');

subplot(3, 1, 3);
stem(0:length(y_tri_tri)-1, y_tri_tri, 'k', 'filled');
grid on;
title('Case (iii): Triangular * Triangular (Cubic Spline Output)');
xlabel('n');
ylabel('Amplitude');

% Custom convolution function without conv command
function y = custom_conv(x, h)
    N1 = length(x);
    N2 = length(h);
    L = N1 + N2 - 1;
    y = zeros(1, L);
    for n = 1:L
        for k = 1:N1
            if (n - k + 1 >= 1) && (n - k + 1 <= N2)
                y(n) = y(n) + x(k) * h(n - k + 1);
            end
        end
    end
end