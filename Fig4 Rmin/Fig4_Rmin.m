clear; tic; rng(1);

figure(1); clf;
set(figure(1), 'Color', 'w', 'Position', [0 0 1628 814]);
fig = tightsubplot(2, 4, [0 0], [0.003 0.001], [0.003 0.003]);
L = [96 96 96 96 96 480 960];
Evap = [1 0.6 0.2 0.1 1 1 1];
dx = [200 200 200 200 200 1000 2000];
for j = 1:numel(L)
    set(gcf, 'CurrentAxes', fig(j)); hold on;
    load(['Evap=' num2str(Evap(j)) '_dx=' num2str(dx(j)) '.mat']);
    stat = zeros(30, 3);
    statRan = zeros(30, 3);
    T = min(p(:, 3));
    q = p((p(:, 3) >= T) & (p(:, 3) < T+12), :);
    num = size(q, 1);
    for dt = 1:30
        DKd = zeros(num, 1);
        DKr = zeros(num, 1);
        for i = 1:num
            qn = p((p(:, 3) > p(i, 3)+0.01) & (p(:, 3) < p(i, 3)+dt+0.01), :);
            S = multiply([qn(:, 1:3) ones(size(qn, 1), 1) (1:4:4*size(qn, 1))']);
            [~, DK] = knnsearch(S(:, 1:2), p(i, 1:2), 'K', 1);
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
    plot(statRan(:, 1), statRan(:, 2)*L(j), '-r', 'Color', [0.9451 0.4118 0.0745], 'LineWidth', 4);
    plot(stat(:, 1), stat(:, 2)*L(j), '-b', 'Color', [0.2588 0.5725 0.7765], 'LineWidth', 4);
    plot(statRan(:, 1), (statRan(:, 2)+statRan(:, 3))*L(j), ':r', 'Color', [0.9451 0.4118 0.0745], 'LineWidth', 3);
    plot(statRan(:, 1), (statRan(:, 2)-statRan(:, 3))*L(j), ':r', 'Color', [0.9451 0.4118 0.0745], 'LineWidth', 3);
    plot(stat(:, 1), (stat(:, 2)+stat(:, 3))*L(j), ':b', 'Color', [0.2588 0.5725 0.7765], 'LineWidth', 3);
    plot(stat(:, 1), (stat(:, 2)-stat(:, 3))*L(j), ':b', 'Color', [0.2588 0.5725 0.7765], 'LineWidth', 3);
    set(gca, 'Box', 'on', 'LineWidth', 3, 'XScale', 'log', 'YScale', 'log', 'XTick', [1 2 5 10 20 50], 'YTick', [1 2 5 10 20 50]);
    axis([1 30 1 40], 'square');
    if j > 4
        axis([1 30 1 200], 'square');
    end
end
fig = gcf; fig.PaperSize = [fig.PaperPosition(3) fig.PaperPosition(4)];
%print('Fig4_Rmin.pdf', '-dpdf');
toc