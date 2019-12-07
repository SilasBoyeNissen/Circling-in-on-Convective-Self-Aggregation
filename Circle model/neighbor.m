function NBf = neighbor(C, G, S)
lav = find(S(:, 4) == G);
Sg = S(lav, :);
n = 1;
inc = min(size(Sg, 1)-1, 400);
NB = zeros(10*size(lav, 1), 3);
[ID, D] = knnsearch(Sg(:, 1:2), Sg(1:4:end, 1:2), 'K', inc+1);
for i = 1:4:size(lav, 1)
    ins = ID((i+3)/4, 2:inc+1);
    in = ins(D((i+3)/4, 2:inc+1) < 2*C(3));
    xy = Sg(i, 1:2) - Sg(in, 1:2);
    NBs = in(sum((xy(:, 1)/2 - xy(:, 1)').^2 + (xy(:, 2)/2 - xy(:, 2)').^2 < (xy(:, 1).^2 + xy(:, 2).^2)/4, 2) <= 20)';
    NB(n:n+size(NBs, 1)-1, :) = [zeros(size(NBs, 1), 1) i*ones(size(NBs, 1), 1) NBs];
    n = n + size(NBs, 1);
end
NB(n:end, :) = [];
NB = unique(sort(NB, 2), 'rows');
NB(NB>0) = lav(NB(NB>0));

j = 1;
NBf = NaN(1e7, 7);
for i = 1:size(NB, 1)
    NBi = NB(i, :);
    if ~isequal(S(NBi(:, 2), 6:7), S(NBi(:, 3), 6:7))
        T = cp2cols(C, Sg, S(NBi(:, 2:3), :));
        NBf(j:j+size(T, 1)-1, :) = [T(:, 1) ones(size(T, 1), 2).*NBi(2:3) T(:, 2:5)];
        j = j + size(T, 1);
    end
end
NBf(isnan(NBf(:, 1)), :) = [];