clc; clear; tic; rng(1);
figure(1); clf;
set(figure(1), 'Color', 'w', 'Position', [0 0 1000 500]);
LW = 2;
FS = 20;

subplot(1, 2, 1); hold on;
for F = [0.1 0.2 0.6 1]
    load(['../Data RCE/_trackedRainEvents/_matFiles/Evap=' num2str(F) '_dx=200.mat']);
    a = zeros(6*24, 1);
    for i = 1:6*24
        a(i) = sum((p(:, 3) >= i) + (p(:, 3) < i+6) == 2);
    end
    a1 = find(a > 0, 1, 'first');
    a2 = find(a > 0, 1, 'last');
    vec = (1:6*24)/24;
    plot(vec(a1+6:a2-6), a(a1+6:a2-6), 'LineWidth', 2);
end
set(gca, 'Box', 'on', 'FontSize', FS, 'LineWidth', LW, 'XTick', 0:2:6, 'YTick', 0:40:120);
legend({'{\bf Evap = 0.1}, dx = 200 m', '{\bf Evap = 0.2}, dx = 200 m', '{\bf Evap = 0.6}, dx = 200 m', '{\bf Evap = 1.0}, dx = 200 m'})
ylabel('# rainfall tracks per (96 km)^2', 'FontWeight', 'bold');
xlabel('Time [days]', 'FontWeight', 'bold');
axis([0 6 0 120], 'square');
title('Panel A');

j = 1;
L = [1920 960 480 96];
subplot(1, 2, 2); hold on;
for dx = [4000 2000 1000 200]
    load(['../Data RCE/_trackedRainEvents/_matFiles/Evap=1_dx=' num2str(dx) '.mat']);
    a = zeros(6*24, 1);
    for i = 1:6*24
        a(i) = sum((p(:, 3) >= i) + (p(:, 3) < i+6) == 2);
    end
    a1 = find(a > 0, 1, 'first');
    a2 = find(a > 0, 1, 'last');
    vec = (1:6*24)/24;
    plot(vec(a1+6:a2-6), a(a1+6:a2-6)./L(j)^2*96^2, 'LineWidth', 2);
    j = j + 1;
end
set(gca, 'Box', 'on', 'FontSize', FS, 'LineWidth', LW, 'XTick', 0:2:6, 'YTick', 0:40:120);
legend({'Evap = 1, {\bf dx = 4.0 km}', 'Evap = 1, {\bf dx = 2.0 km}', 'Evap = 1, {\bf dx = 1.0 km}', 'Evap = 1, {\bf dx = 0.2 km}'})
ylabel('# rainfall tracks per (96 km)^2', 'FontWeight', 'bold');
xlabel('Time [days]', 'FontWeight', 'bold');
axis([0 6 0 120], 'square');
title('Panel B');

f = gcf; f.PaperSize = [f.PaperPosition(3) f.PaperPosition(4)];
%print('FigS5.pdf', '-dpdf');
toc;