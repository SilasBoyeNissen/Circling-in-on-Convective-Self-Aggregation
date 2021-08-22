clear; tic;
LW2 = 2;
LW3 = 3;
YS = 505;
SIZ = 440;
LRMAX = 4;
LRMIN = 50;
COLB = [8 29 88; 37 52 148; 34 94 168; 29 145 192; 65 182 196]/255;

%% Panel A
figure(1); clf;
load('generated data/data');
set(figure(1), 'Color', 'w', 'Position', [SIZ YS 1.5*SIZ SIZ]);
fig = tightsubplot(1, 1, [0 0], [0.005 0.005], [0.005 0.005]);
set(gcf, 'CurrentAxes', fig(1)); hold on;
plot(q(:, [1 10 20 30 40 50 60 70 80 90 100]), '-', 'Color', ones(1, 3)*0.6, 'LineWidth', 1);
plot(q(:, 1), '-', 'LineWidth', LW3, 'Color', [0.4940, 0.1840, 0.5560]);
plot(q(:, 50), '-', 'LineWidth', LW3, 'Color', [0.4660, 0.6740, 0.1880]);
plot(q(:, 100), '-', 'LineWidth', LW3, 'Color', [0, 0.4470, 0.7410]);
set(gca, 'Box', 'on', 'LineWidth', LW2, 'XScale', 'log', 'XTick', 0:100:500, 'YTick', 0:100:400, 'XTickLabel', [], 'YTickLabel', []);
axis([0 500 0 700]);
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
%print('FigS3A.pdf', '-dpdf');

%% Panel B
figure(2); clf;
set(figure(2), 'Color', 'w', 'Position', [2*SIZ YS SIZ SIZ]);
fig = tightsubplot(1, 1, [0 0], [0.005 0.005], [0.005 0.005]);
set(gcf, 'CurrentAxes', fig(1)); hold on;
histogram(q(:, 1:100)', 0:10:1000, 'Normalization', 'probability', 'Facealpha', 1, 'EdgeColor', COLB(1, :), 'FaceColor', COLB(4, :));
set(gca, 'Box', 'on', 'LineWidth', LW2, 'XTick', 0:100:400, 'YScale', 'log', 'XTickLabel', [], 'YTickLabel', []);
axis([0 400 0.001 1], 'square');
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
%print('FigS3B.pdf', '-dpdf');
toc;