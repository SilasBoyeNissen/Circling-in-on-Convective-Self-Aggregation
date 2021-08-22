function R = calculate(G, p, S)
g = find(p(:, 4) == G);
pg = p(g, :);
ID = cellfun(@(v) v(2:end), rangesearch(pg(:, 1:2), pg(1:4:end, 1:2), 2*S(3)), 'UniformOutput', false);
NB = g([repelem(1:4:4*size(ID, 1), cellfun('prodofsize', ID))' [ID{:}]']);
[~, ia] = unique(sort(floor((NB-1)/4)*4+1, 2), 'rows');
R = NaN(numel(ia), 3);
for i = 1:numel(ia)
    pr = p(NB(ia(i), :), :);
    m = min(pr(:, 3));
    x1 = pr(1, 1); x2 = pr(2, 1); y1 = pr(1, 2); y2 = pr(2, 2); r1 = pr(1, 3)-m; r2 = pr(2, 3)-m+eps;
    xx = (x1 - x2)^2; yy = (y1 - y2)^2; rr = (r1 - r2)^2*xx; sq = sqrt(rr*(xx + yy)); yyy = (y1 + y2);
    dr = -(r1 + r2)/2 + [1 -1]*sq/(2*(r1 - r2)*(x1 - x2));
    dr(dr < eps) = NaN;
    [dr, j] = min(dr);
    if (dr+r1 > S(2)) + (dr+r2 > S(2)) + (dr+r1 < S(3)) + (dr+r2 < S(3)) == 4
        T = [dr - m (x1 + x2)/2 + (-1)^j*rr/(2*sq) ((-1)^j*(y1 - y2)*sq + x1^3*yyy - 3*x1^2*x2*yyy - x2^3*yyy + x1*(3*x2^2 + yy)*yyy - x2*yy*yyy) / (2*(x1 - x2)*(xx + yy))];
        nbs = pg(((pg(:, 5) ~= pr(1, 5)) & (pg(:, 5) ~= pr(2, 5))), 1:3);
        T(any((nbs(:, 3) + T(1)).^2 > (T(2) - nbs(:, 1)).^2 + (T(3) - nbs(:, 2)).^2), 1) = NaN;
        R(i, :) = T;
    end
end
R(isnan(R(:, 1)), :) = [];
R([zeros(size(R, 1), 1) R(:, 2:3)] > 1) = R([zeros(size(R, 1), 1) R(:, 2:3)] > 1) - 1;
R([zeros(size(R, 1), 1) R(:, 2:3)] < 0) = R([zeros(size(R, 1), 1) R(:, 2:3)] < 0) + 1;