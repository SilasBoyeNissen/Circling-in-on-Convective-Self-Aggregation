clear; figure(1); clf; tic;
SIZ = 440;
YS = 505;
COLB = [2 56 88; 4 90 141; 5 112 176; 54 144 192; 116 169 207; 166 189 219; 208 209 230; 236 231 242; 255 247 251]/255;
COLR = [165 15 21; 222 45 38; 251 106 74; 252 174 145; 254 229 217]/255;

%% Panel A
j = 1;
LW3 = 3;
LW2 = 2;
LRMAX = 4;
LRMIN = 50;
shows = [];
figure(1); clf;
set(figure(1), 'Color', 'w', 'Position', [0 YS SIZ SIZ]);
fig = tightsubplot(3, 3, [0 0], [0.006 0.003], [0.003 0.003]);
load(['LRmin' num2str(LRMIN) '-LRmax' num2str(LRMAX) '-1']);
p(:, 3) = p(:, 3) - max(p(:, 3));
for DT = [0.01 0.02 0.041 1 3 5 7 10 15]
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
    for color = 1:size(COLB, 3)
        V = T(vis, :);
        V(:, 4) = V(:, 4) - min(V(:, 4));
        if DT < 0.5
            V(:, 4) = V(:, 4) + 2;
        end
        if DT < 0.5
            rectangle('Position', [0 0 1 1], 'FaceColor', [0.8 0.8 1]); hold on;
        else
            rectangle('Position', [0 0 1 1], 'FaceColor', [0.15 0.15 1]); hold on;
        end
        for G = unique(V(:, 4))'
            t1 = find(V(:, 4) == G)';
            for i = t1
                rectangle('Position', [V(i, 1)-min(V(i, 3), 1/LRMAX) V(i, 2)-min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX)], ...
                    'Curvature', [1 1], 'EdgeColor', 'k', 'LineWidth', LW2);
            end
            for i = t1
                if DT < 0.5
                    rectangle('Position', [V(i, 1)-min(V(i, 3), 1/LRMAX) V(i, 2)-min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX)], ...
                        'Curvature', [1 1], 'EdgeColor', 'none', 'FaceColor', [0.7 0.7 1]+[0.1 0.1 0]*G);
                else
                    rectangle('Position', [V(i, 1)-min(V(i, 3), 1/LRMAX) V(i, 2)-min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX)], ...
                        'Curvature', [1 1], 'EdgeColor', 'none', 'FaceColor', [0.2 0.2 1]+[0.1 0.1 0]*G);
                end
            end
        end
        rectangle('Position', [0 0 1 1], 'EdgeColor', 'k', 'FaceColor', 'none', 'LineWidth', LW2); hold on;
        axis([0 1 0 1], 'square');
        j = j + 1;
    end
end
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
print('Fig5_circle_model_panelA.pdf', '-dpdf');

%% Panel B
figure(2); clf;
set(figure(2), 'Color', 'w', 'Position', [SIZ YS SIZ SIZ]);
fig = tightsubplot(1, 1, [0 0], [0.005 0.005], [0.005 0.005]);
set(gcf, 'CurrentAxes', fig(1)); hold on;
load(['LRmin' num2str(LRMIN) '-LRmax' num2str(LRMAX)]);
plot(q(:, [1:29 201]), '-', 'Color', ones(1, 3)*0.6, 'LineWidth', 0.4);
plot(q(:, 1), '-', 'LineWidth', LW3, 'Color', [0.4940, 0.1840, 0.5560]);
plot(q(:, 2), '-', 'LineWidth', LW3, 'Color', [0.4660, 0.6740, 0.1880]);
plot(q(:, 201), '-', 'LineWidth', LW3, 'Color', [0, 0.4470, 0.7410]);
plot([0 shows(3:end)], [400; q(shows(3:end), 201)], '.k', 'MarkerSize', 49)
set(gca, 'Box', 'on', 'LineWidth', LW2, 'XTick', 0:100:500, 'YTick', 0:100:400, 'XTickLabel', [], 'YTickLabel', []);
axis([0 500 0 400], 'square');
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
print('Fig5_circle_model_panelB.pdf', '-dpdf');

%% Panel C
figure(3); clf;
set(figure(3), 'Color', 'w', 'Position', [2*SIZ YS SIZ SIZ]);
fig = tightsubplot(1, 1, [0 0], [0.005 0.005], [0.005 0.005]);
set(gcf, 'CurrentAxes', fig(1)); hold on;
histogram(q(:, 1:200)', 0:10:1000, 'Normalization', 'probability', 'Facealpha', 1, 'EdgeColor', COLB(2, :), 'FaceColor', COLB(5, :));
set(gca, 'Box', 'on', 'LineWidth', LW2, 'XTick', 0:100:400, 'YScale', 'log', 'XTickLabel', [], 'YTickLabel', []);
axis([0 400 0.001 1], 'square');
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
print('Fig5_circle_model_panelC.pdf', '-dpdf');

%% Panel D
figure(4); clf;
x = -10:8:1000;
LRminV = 20:10:80;
shift = [-1.5 0 1.5];
set(figure(4), 'Color', 'w', 'Position', [0 0 SIZ SIZ]);
fig = tightsubplot(1, 1, [0 0], [0.005 0.005], [0.005 0.005]);
set(gcf, 'CurrentAxes', fig(1)); hold on;
plot([10 LRminV 90], 1./(2*(1./[10 LRminV 90])), '--', 'Color', 'k', 'LineWidth', LW2);
plot([10 LRminV 90], 1.^2./(10*(1./[10 LRminV 90]).^2), '--', 'Color', 'k', 'LineWidth', LW2);
plot([10 LRminV 90], 1.5*[10 LRminV 90], '--', 'Color', [0 0 0 0.5], 'LineWidth', 1);
for LRmax = 2:4
    wLow = [];
    wHigh = [];
    statLow = [];
    statMid = [];
    statHigh = [];
    for LRmin = LRminV
        load(['LRmin' num2str(LRmin) '-LRmax' num2str(LRmax)]);
        h = histogram(q(:, 1:200)', x, 'Normalization', 'probability').Values;
        [pks, l, w] = findpeaks(h);
        [~, I] = maxk(pks, 2);
        wLow = [wLow; w(I(1))];
        wHigh = [wHigh; w(I(2))];
        statLow = [statLow; x(l(I(1)))];
        statHigh = [statHigh; x(l(I(2)))];
        statMid = [statMid; x(l(I(1))+find(islocalmin(h(l(I(1)):l(I(2)))), 1)-1)];
    end
    scatter(LRminV+shift(LRmax-1), statMid, 50, COLR(LRmax-1, :), 'filled', 'MarkerFaceAlpha', 0.5);
    errorbar(LRminV+shift(LRmax-1), statLow, wLow, '.', 'Color', COLR(LRmax-1, :), 'LineWidth', 5);
    errorbar(LRminV+shift(LRmax-1), statHigh, wHigh, '.', 'Color', COLR(LRmax-1, :), 'LineWidth', LW3);
end
set(gca, 'Box', 'on', 'LineWidth', LW2, 'XTick', 20:20:80, 'YTick', 0:200:600, 'XTickLabel', [], 'YTickLabel', []);
axis([10 90 0 700], 'square');
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
print('Fig5_circle_model_panelD.pdf', '-dpdf');

%% Panel E
x = 0:501;
LRmin = 20;
figure(5); clf;
set(figure(5), 'Color', 'w', 'Position', [SIZ 0 SIZ SIZ]);
fig = tightsubplot(1, 1, [0 0], [0.005 0.005], [0.005 0.005]);
set(gcf, 'CurrentAxes', fig(1)); hold on;
for LRmax = 2:6
	load(['LRmin' num2str(LRmin) '-LRmax' num2str(LRmax)]);
    y = 1-histcounts(sum(q(:, 1:200) > 1.5*LRmin)', x, 'Normalization', 'cdf');
    t1 = find(y < 1, 1);
    t2 = find(y <= 0, 1);
    plot(y, '-', 'Color', COLR(LRmax-1, :), 'LineWidth', 1.5);
    h = plot(fit(x(t1:t2)', y(t1:t2)', fittype('exp1')), '--');
    set(h, 'Color', COLR(LRmax-1, :), 'LineWidth', LW2);
end
set(gca, 'Box', 'on', 'LineWidth', LW2, 'XTick', 0:100:500, 'YScale', 'log', 'XTickLabel', [], 'YTickLabel', []);
legend('off');
axis([0 500 0.01 1], 'square');
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
print('Fig5_circle_model_panelE.pdf', '-dpdf');

%% Panel F
figure(6); clf;
set(figure(6), 'Color', 'w', 'Position', [2*SIZ 0 SIZ SIZ]);
fig = tightsubplot(1, 1, [0 0], [0.005 0.005], [0.005 0.005]);
set(gcf, 'CurrentAxes', fig(1)); hold on;
yLim = 500;
for LRmax = 2:6
    sav = [];
    for LRmin = LRminV
        load(['LRmin' num2str(LRmin) '-LRmax' num2str(LRmax)]);
        y = 1-histcounts(sum(q(:, 1:200) > 1.5*LRmin), x, 'Normalization', 'cdf');
        t1 = find(y < 1, 1);
        t2 = find(y <= 0, 1);
        sav = [sav -1./fit(x(t1:t2)', y(t1:t2)', fittype('exp1')).b];
    end
    plot(LRminV(sav<yLim), sav(sav<yLim), '.', 'Color', COLR(LRmax-1, :), 'MarkerSize', 40);
    xx = 0:100;
    f = fit(LRminV(sav<yLim)', sav(sav<yLim)', fittype('poly1'));
    plot(xx, f.p1*xx+f.p2, '--', 'Color', COLR(LRmax-1, :), 'LineWidth', 1);
end
set(gca, 'Box', 'on', 'LineWidth', LW2, 'XTick', 20:20:80, 'YTick', 0:100:500, 'XTickLabel', [], 'YTickLabel', []);
legend('off');
axis([10 90 0 500], 'square');
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
print('Fig5_circle_model_panelF.pdf', '-dpdf');
toc;