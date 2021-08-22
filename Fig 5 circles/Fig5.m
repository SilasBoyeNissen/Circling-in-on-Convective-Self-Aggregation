clear; figure(1); clf; tic;
LW2 = 2;
LW3 = 3;
YS = 505;
SIZ = 440;
LRMAX = 4;
LRMIN = 50;
COLB = [8 29 88; 37 52 148; 34 94 168; 29 145 192; 65 182 196]/255;
    
%% Panel A
j = 1;
shows = [];
figure(1); clf;
set(figure(1), 'Color', 'w', 'Position', [0 YS 7*SIZ/2 SIZ/2]);
fig = tightsubplot(1, 7, [0 0], [0.006 0.003], [0.004 0.004]);
load(['generated data/LRmin' num2str(LRMIN) '-LRmax' num2str(LRMAX) '-1']);
p(:, 3) = p(:, 3) - max(p(:, 3));
for DT = [0.001 0.01 0.03 1 3 10 15]
    set(gcf, 'CurrentAxes', fig(j)); hold on;
    T = p + [0 0 DT 0 0];
    T(T(:, 3) < 0, :) = [];
    T(T(:, 3) > 1, :) = [];
    T((T(:, 1) > 1) + (T(:, 2) > 1) + (((T(:, 1)-1).^2 + (T(:, 2)-1).^2) > T(:, 3).^2) == 3, :) = [];
    T((T(:, 1) > 1) + (T(:, 2) < 0) + (((T(:, 1)-1).^2 + T(:, 2).^2) > T(:, 3).^2) == 3, :) = [];
    T((T(:, 1) < 0) + (T(:, 2) > 1) + ((T(:, 1).^2 + (T(:, 2)-1).^2) > T(:, 3).^2) == 3, :) = [];
    T((T(:, 1) < 0) + (T(:, 2) < 0) + ((T(:, 1).^2 + T(:, 2).^2) > T(:, 3).^2) == 3, :) = [];
    T((T(:, 1) < 0) + (T(:, 2) > 0) + (T(:, 2) < 1) + (abs(T(:, 1)) > T(:, 3)) == 4, :) = [];
    T((T(:, 2) < 0) + (T(:, 1) > 0) + (T(:, 1) < 1) + (abs(T(:, 2)) > T(:, 3)) == 4, :) = [];
    T((T(:, 1) > 1) + (T(:, 2) > 0) + (T(:, 2) < 1) + (T(:, 1)-1 > T(:, 3)) == 4, :) = [];
    T((T(:, 2) > 1) + (T(:, 1) > 0) + (T(:, 1) < 1) + (T(:, 2)-1 > T(:, 3)) == 4, :) = [];
    shows = [shows round(mean(T(:, 4)))];
    vis = find(T(:, 4) >= max(T(:, 4))-8)';
    V = T(vis, :);
    V(:, 4) = V(:, 4) - min(V(:, 4));
    rectangle('Position', [0 0 1 1], 'FaceColor', [1 1 1]); hold on;
    for G = unique(V(:, 4))'
        t1 = find(V(:, 4) == G)';
        if DT > 5
            G = G + 1;
        end
        for i = t1
            rectangle('Position', [V(i, 1)-min(V(i, 3), 1/LRMAX) V(i, 2)-min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX)], ...
                'Curvature', [1 1], 'EdgeColor', 'k', 'LineWidth', LW2);
        end
        if DT < 1
            for i = t1
                rectangle('Position', [V(i, 1)-min(V(i, 3), 1/LRMAX) V(i, 2)-min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX)], ...
                    'Curvature', [1 1], 'EdgeColor', 'none', 'FaceColor', [1 1 1]-[1/3 1/3 0]*(G+1));
            end
        else
            for i = t1
                rectangle('Position', [V(i, 1)-min(V(i, 3), 1/LRMAX) V(i, 2)-min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX)], ...
                    'Curvature', [1 1], 'EdgeColor', 'none', 'FaceColor', [1 1 1]-[0.1 0.1 0]*G);
            end
        end
    end
    rectangle('Position', [0 0 1 1], 'EdgeColor', 'k', 'FaceColor', 'none', 'LineWidth', 1); hold on;
    axis([0 1 0 1], 'square');
    j = j + 1;
end
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
%print('Fig5A.pdf', '-dpdf');

%% Panel B
figure(2); clf;
set(figure(2), 'Color', 'w', 'Position', [SIZ YS SIZ SIZ]);
fig = tightsubplot(1, 1, [0 0], [0.005 0.005], [0.005 0.005]);
set(gcf, 'CurrentAxes', fig(1)); hold on;
load(['generated data/LRmin' num2str(LRMIN) '-LRmax' num2str(LRMAX)]);
plot(q(:, [3:29 201]), '-', 'Color', ones(1, 3)*0.6, 'LineWidth', 0.4);
plot(q(:, 1), '-', 'LineWidth', LW3, 'Color', [0.4940, 0.1840, 0.5560]);
plot(q(:, 2), '-', 'LineWidth', LW3, 'Color', [0.4660, 0.6740, 0.1880]);
plot(q(:, 201), '-', 'LineWidth', LW3, 'Color', [0, 0.4470, 0.7410]);
plot(shows(4:end), q(shows(4:end), 201), '.k', 'MarkerSize', 70);
set(gca, 'Box', 'on', 'LineWidth', LW2, 'XTick', 0:100:500, 'YTick', 0:100:400, 'XTickLabel', [], 'YTickLabel', []);
axis([0 500 0 400], 'square');
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
%print('Fig5B.pdf', '-dpdf');

%% Panel C
figure(3); clf;
set(figure(3), 'Color', 'w', 'Position', [2*SIZ YS SIZ SIZ]);
fig = tightsubplot(1, 1, [0 0], [0.005 0.005], [0.005 0.005]);
set(gcf, 'CurrentAxes', fig(1)); hold on;
histogram(q(:, 1:200)', 0:10:1000, 'Normalization', 'probability', 'Facealpha', 1, 'EdgeColor', COLB(1, :), 'FaceColor', COLB(4, :));
set(gca, 'Box', 'on', 'LineWidth', LW2, 'XTick', 0:100:400, 'YScale', 'log', 'XTickLabel', [], 'YTickLabel', []);
axis([0 400 0.001 1], 'square');
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
%print('Fig5C.pdf', '-dpdf');

%% Panel D
j = 1;
figure(4); clf;
x = -10:8:1000;
LRminV = 20:10:80;
shift = [-2 0 2];
set(figure(4), 'Color', 'w', 'Position', [0 0 SIZ SIZ]);
fig = tightsubplot(1, 1, [0 0], [0.005 0.005], [0.005 0.005]);
set(gcf, 'CurrentAxes', fig(1)); hold on;
plot([10 LRminV 100], 1./(2*(1./[10 LRminV 100])), '--', 'Color', [0 0 0 0.5], 'LineWidth', LW3);
plot([10 LRminV 100], 1.^2./(10*(1./[10 LRminV 100]).^2), '--', 'Color', [0 0 0 0.5], 'LineWidth', LW3);
plot([10 LRminV 100], 1.5*[10 LRminV 100], '--', 'Color', [0 0 0 0.5], 'LineWidth', LW3);
for LRmax = 2:4
    wLow = [];
    wHigh = [];
    statLow = [];
    statMid = [];
    statHigh = [];
    for LRmin = LRminV
        load(['generated data/LRmin' num2str(LRmin) '-LRmax' num2str(LRmax)]);
        h = histogram(q(:, 1:200)', x, 'Normalization', 'probability').Values;
        [pks, l, w] = findpeaks(h);
        [~, I] = maxk(pks, 2);
        wLow = [wLow; w(I(1))];
        wHigh = [wHigh; w(I(2))];
        statLow = [statLow; x(l(I(1)))];
        statHigh = [statHigh; x(l(I(2)))];
        statMid = [statMid; x(l(I(1))+find(islocalmin(h(l(I(1)):l(I(2)))), 1)-1)];
    end
    scatter(LRminV+shift(j), statMid, 90, COLB(j, :), 'filled');
    errorbar(LRminV+shift(j), statLow, wLow, '.', 'Color', COLB(j, :), 'LineWidth', 10);
    errorbar(LRminV+shift(j), statHigh, wHigh, '.', 'Color', COLB(j, :), 'LineWidth', 4);
    j = j + 1;
end
set(gca, 'Box', 'on', 'LineWidth', LW2, 'XTick', 20:20:80, 'YTick', 0:200:600, 'XTickLabel', [], 'YTickLabel', []);
axis([10 90 0 700], 'square');
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
%print('Fig5D.pdf', '-dpdf');

%% Panel E
x = 0:501;
LRmin = 20;
figure(5); clf;
set(figure(5), 'Color', 'w', 'Position', [SIZ 0 SIZ SIZ]);
fig = tightsubplot(1, 1, [0 0], [0.005 0.005], [0.005 0.005]);
set(gcf, 'CurrentAxes', fig(1)); hold on;
for LRmax = 2:6
	load(['generated data/LRmin' num2str(LRmin) '-LRmax' num2str(LRmax)]);
    y = 1-histcounts(sum(q(:, 1:200) > 1.5*LRmin)', x, 'Normalization', 'cdf');
    t1 = find(y < 1, 1);
    t2 = find(y <= 0, 1);
    plot(y, '-', 'Color', COLB(LRmax-1, :), 'LineWidth', LW3);
    h = plot(fit(x(t1:t2)', y(t1:t2)', fittype('exp1')), '--');
    set(h, 'Color', COLB(LRmax-1, :), 'LineWidth', LW3);
end
set(gca, 'Box', 'on', 'LineWidth', LW2, 'XTick', 0:100:500, 'YScale', 'log', 'XTickLabel', [], 'YTickLabel', []);
legend('off');
axis([0 500 0.01 1], 'square');
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
%print('Fig5E.pdf', '-dpdf');

%% Panel F
figure(6); clf;
set(figure(6), 'Color', 'w', 'Position', [2*SIZ 0 SIZ SIZ]);
fig = tightsubplot(1, 1, [0 0], [0.005 0.005], [0.005 0.005]);
set(gcf, 'CurrentAxes', fig(1)); hold on;
yLim = 500;
for LRmax = 2:6
    sav = [];
    for LRmin = LRminV
        load(['generated data/LRmin' num2str(LRmin) '-LRmax' num2str(LRmax)]);
        y = 1-histcounts(sum(q(:, 1:200) > 1.5*LRmin), x, 'Normalization', 'cdf');
        t1 = find(y < 1, 1);
        t2 = find(y <= 0, 1);
        sav = [sav -1./fit(x(t1:t2)', y(t1:t2)', fittype('exp1')).b];
    end
    plot(LRminV(sav<yLim), sav(sav<yLim), '.', 'Color', COLB(LRmax-1, :), 'MarkerSize', 50);
    xx = 0:100;
    f = fit(LRminV(sav<yLim)', sav(sav<yLim)', fittype('poly1'));
    plot(xx, f.p1*xx+f.p2, '--', 'Color', COLB(LRmax-1, :), 'LineWidth', LW3);
end
set(gca, 'Box', 'on', 'LineWidth', LW2, 'XTick', 20:20:80, 'YTick', 0:100:500, 'XTickLabel', [], 'YTickLabel', []);
legend('off');
axis([10 100 0 500], 'square');
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
%print('Fig5F.pdf', '-dpdf');
toc;