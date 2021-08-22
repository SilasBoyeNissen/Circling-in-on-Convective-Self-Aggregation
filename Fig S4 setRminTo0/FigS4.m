clear; figure(1); clf; tic;
set(gcf, 'color', 'w', 'Position', [0 0 1000 500]);

N = 100;
gmax = 12;
runs = 20;
q = zeros(gmax, runs);
for seed = 1:runs
        load(['generated data/S' num2str(N) '-' num2str(seed)]);
        q(:, seed) = histcounts(S(:, 4), 0.5:gmax+0.5)';
end
stat = q(2:end, :)./q(1:end-1, :);

subplot(1, 2, 1);
plot(1:gmax, mean(q/4, 2), 'Color', [107, 174, 214]/255, 'LineWidth', 2); hold on;
errorbar(1:gmax, mean(q/4, 2), std(q/4, [], 2), '.', 'Color', [8, 81, 156]/255, 'LineWidth', 3)
title('Panel A');
set(gca, 'Box', 'on', 'FontSize', 20, 'LineWidth', 2, 'Yscale', 'log');
xlabel('Generation ({\itg})', 'FontSize', 20, 'Fontweight', 'bold');
ylabel('Circles ({\itN_g})', 'FontSize', 20, 'Fontweight', 'bold');
axis([0 12 1e2 1e5], 'square');

subplot(1, 2, 2);
plot(1:gmax-1, mean(stat, 2), 'Color', [107, 174, 214]/255, 'LineWidth', 2); hold on;
errorbar(1:gmax-1, mean(stat, 2), std(stat, [], 2), '.', 'Color', [8, 81, 156]/255, 'LineWidth', 3)
title('Panel B');
set(gca, 'Box', 'on', 'FontSize', 20, 'LineWidth', 2, 'YTick', 1.8:0.1:2.1);
xlabel('Generation ({\itg})', 'FontSize', 20, 'Fontweight', 'bold');
ylabel('Rate ({\itr_g})', 'FontSize', 20, 'Fontweight', 'bold');
axis([0 12 1.8 2.1], 'square');

fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
%print('FigS4.pdf', '-dpdf');
toc;