clc; clear; tic; rng(1);
LW = 2;
FS = 20;

j = 1;
figure(1); clf; hold on;
set(figure(1), 'Color', 'w', 'Position', [0 0 500 500]);
for F = [0.1 0.2 0.6 1]
    load(['Evap=' num2str(F) '_dx=200.mat']);
    a = zeros(6*24, 1);
    for i = 1:6*24
        a(i) = sum((p(:, 3) >= i) + (p(:, 3) < i+6) == 2);
    end
    a1 = find(a > 0, 1, 'first');
    a2 = find(a > 0, 1, 'last');
    vec = (1:6*24)/24;
    plot(vec(a1+6:a2-6), a(a1+6:a2-6), 'LineWidth', 2);
end
set(gca, 'Box', 'on', 'FontSize', FS, 'LineWidth', LW, 'XTick', 0:2:6, 'YTick', 0:20:100);
axis([0 6 0 100]);
xlabel('Time [days]', 'FontWeight', 'bold');
ylabel('# rain events', 'FontWeight', 'bold');
legend({'Evap = 0.1', 'Evap = 0.2', 'Evap = 0.6', 'Evap = 1'})
f = gcf; f.PaperSize = [f.PaperPosition(3) f.PaperPosition(4)];
%print('FigS3_NoEvents.pdf', '-dpdf');
toc;