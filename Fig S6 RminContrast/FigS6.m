clear; tic; rng(1);

figure(1); clf;
set(figure(1), 'Color', 'w', 'Position', [0 0 1628 850]);
fig = tightsubplot(2, 4, [0.02 0], [0.003 0.001], [0.003 0.003]);
L = [96 96 96 96 96 480 960 1920];
Evap = [1 0.6 0.2 0.1 1 1 1 1];
dx = [200 200 200 200 200 1000 2000 4000];
for j = 1:numel(L)
    set(gcf, 'CurrentAxes', fig(j)); hold on;
    load(['../Data RCE/_trackedRainEvents/_matFiles/Evap=' num2str(Evap(j)) '_dx=' num2str(dx(j)) '.mat']);
    stat = zeros(30, 3);
    statRan = zeros(30, 3);
    T = min(p(:, 3));
    q = p((p(:, 3) >= T) & (p(:, 3) < T+12), :);
    num = size(q, 1);
    parfor dt = 1:30
        DKd = zeros(num, 1);
        DKr = zeros(num, 1);
        for i = 1:num
            qn = p((p(:, 3) > p(i, 3)) & (p(:, 3) < p(i, 3)+dt), :);
            S = multiply([qn(:, 1:3) ones(size(qn, 1), 1) (1:4:4*size(qn, 1))']);
            [~, DK] = dsearchn(S(:, 1:2), p(i, 1:2));
            DKd(i) = DK;
            DKr(i) = size(qn, 1);
        end
        DKd = DKd(:, 1);
        N = mean(DKr);
        X = 0:0.001:0.5;
        W = 2*N.*pi.*X.*(1-pi.*X.^2./1.^2).^(-1+N)./1.^2;
        Wmean = X*W'/sum(W);
        stat(dt, :) = [dt mean(DKd) std(DKd)];
        statRan(dt, :) = [dt Wmean sqrt((sum(W.*(X-Wmean).^2))/((length(X)-1)*sum(W)/length(X)))];
    end
    plot([1 30], [1 1], '--k', 'Color', [0.5, 0.5, 0.5], 'LineWidth', 3);
    plot(stat(:, 1), (stat(:, 2)*L(j))./(statRan(:, 2)*L(j)), '-g', 'Color', [0, 0.5, 0], 'LineWidth', 4);
    plot(stat(:, 1), ((stat(:, 2)+stat(:, 3))*L(j))./((statRan(:, 2)+statRan(:, 3))*L(j)), ':g', 'Color', [0.4660, 0.6740, 0.1880], 'LineWidth', 3);
    plot(stat(:, 1), ((stat(:, 2)-stat(:, 3))*L(j))./((statRan(:, 2)-statRan(:, 3))*L(j)), ':g', 'Color', [0.4660, 0.6740, 0.1880], 'LineWidth', 3);
    set(gca, 'Box', 'on', 'LineWidth', 3, 'XScale', 'log', 'XTick', [1 2 5 10 20 50], 'YTick', 0:0.25:2.5);
    axis([1 30 0.5 2.25], 'square');
end
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
%print('FigS6.pdf', '-dpdf');
toc