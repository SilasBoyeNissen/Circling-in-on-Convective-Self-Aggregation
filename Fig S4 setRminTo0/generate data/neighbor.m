function NB = neighbor(C, ALL, lav, S)
NB = zeros(size(lav, 1)/4, 4);
inc = min(size(S, 1)-1, 200);
n = 1;
for i = 1:4:size(lav, 1)
    [~, ID] = mink(sqrt((S(:, 1)' - S(i, 1)).^2 + (S(:, 2)' - S(i, 2)).^2) - S(i, 3) - S(:, 3)', inc+1, 2);
    in = ID(1, 2:inc+1);
    x = S(i, 1) - S(in, 1);
    y = S(i, 2) - S(in, 2);
    nDis = (x/2 - x').^2 + (y/2 - y').^2;
    nDis(eye(inc, inc) == 1) = 1000;
    NBs = in(sum(nDis < (x.^2 + y.^2)/4, 2) <= 20);
    for j = 1:size(NBs, 2)
        NB(n, :) = [0 0 i NBs(j)];
        n = n + 1;
    end
end
NB = unique(sort(NB, 2), 'rows');
NB(NB>0) = lav(NB(NB>0));
tak = NB(:, 3:4);
parfor i = 1:size(NB, 1)
	NB(i, 1) = cp2cols(tak(i, :), ALL);
end
NB(isnan(NB(:, 1)), :) = [];