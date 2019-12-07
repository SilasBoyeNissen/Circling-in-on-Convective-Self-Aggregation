function T = cp2cols(C, Sg, Sr)
[m, k] = mink(Sr(:, 3), 2);
no = 0;
while rand() < C(5)
    no = no + 1;
end
Sr = Sr(k, :);
So = Sr(1, 1:2)';
Sr(:, 3) = Sr(:, 3) - m(1);
Sr(:, 1:2) = Sr(:, 1:2) - Sr(1, 1:2);
o = atan(Sr(2, 2)/Sr(2, 1));
Sr(2, 1:2) = [cos(o) sin(o); -sin(o) cos(o)]*Sr(2, 1:2)';
nbs = ((Sg(:, 5) == Sr(1, 5)) + (Sg(:, 5) == Sr(2, 5)) == 0);
x2 = Sr(2, 1);
r2 = Sr(2, 3);
y = (round(rand())*2-1)*((0:C(4):no*C(4))');
r = -r2/2 + sqrt(x2^2*(r2^2 - x2^2 - 4*y.^2))/(2*sqrt(r2^2 - x2^2));
y = y((r > C(2)) + (r < C(3)-r2) == 2);
r = r((r > C(2)) + (r < C(3)-r2) == 2);
x = -(2*r*r2 + r2^2 - x2^2) / (2*x2);
T = nan(size(r, 1), 5);
if sum(y == 0)
    for i = 1:size(r, 1)
        T(i, :) = [r(i) - m(1) ([cos(o) -sin(o); sin(o) cos(o)]*[x(i); y(i)] + So)' i no+1];
    end
    T([zeros(size(T, 1), 1) T(:, 2:3) zeros(size(T, 1), 2)] > 1) = T([zeros(size(T, 1), 1) T(:, 2:3) zeros(size(T, 1), 2)] > 1) - 1;
    T([zeros(size(T, 1), 1) T(:, 2:3) zeros(size(T, 1), 2)] < 0) = T([zeros(size(T, 1), 1) T(:, 2:3) zeros(size(T, 1), 2)] < 0) + 1;
    T(any((Sg(nbs, 3)' + T(:, 1)).^2 > (T(:, 2) - Sg(nbs, 1)').^2 + (T(:, 3) - Sg(nbs, 2)').^2, 2), 1) = NaN;
    T(find(~isnan(T(:, 1)), 1, 'last'), 4) = no+1;
end