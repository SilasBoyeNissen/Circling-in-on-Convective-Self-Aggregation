function [dr, T] = cp2cols(ij, S)
[m, k] = mink(S(ij, 3), 2);
ij = ij(k);
T = NaN;
if sqrt((S(ij(2), 2)-S(ij(1), 2))^2 + (S(ij(2), 1)-S(ij(1), 1))^2) < (S(ij(1), 3) + S(ij(2), 3))
    dr = NaN;
else
    Sr = S(ij, 1:3);
    Sr(:, 3) = Sr(:, 3) - m(1);
    Sr(:, 1:2) = Sr(:, 1:2) - S(ij(1), 1:2);
    o = atan(Sr(2, 2)/Sr(2, 1));
    Sr(2, 1:2) = [cos(o) sin(o); -sin(o) cos(o)]*Sr(2, 1:2)';
    dr = (abs(Sr(2, 1))-Sr(2, 3))/2 - m(1);
    if dr >= 0
        T = [([cos(o) -sin(o); sin(o) cos(o)]*[sign(Sr(2, 1))*(dr + m(1)); 0] + S(ij(1), 1:2)')' 0 S(ij(1), 4)+1 size(S, 1)+1];
        nbs = ((S(:, 4) == S(ij(1), 4)) + (S(:, 5) == S(ij(1), 5)) + (S(:, 5) == S(ij(2), 5)) == 1);
        S(:, 3) = S(:, 3) + dr;
        T(T(1:2) > 1) = T(T(1:2) > 1) - 1;
        T(T(1:2) < 0) = T(T(1:2) < 0) + 1;
        if ~all(S(nbs, 3) < sqrt((T(1) - S(nbs, 1)).^2 + (T(2) - S(nbs, 2)).^2))
            dr = NaN;
        end
    else
        dr = NaN;
    end
end