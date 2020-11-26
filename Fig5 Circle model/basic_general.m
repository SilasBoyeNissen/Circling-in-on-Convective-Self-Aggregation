clear; close all; tic;
S = [100 0.05 0.2 1]; % N Rmin Rmax seed
rng(S(1, 4));
p = zeros(1e7, 5);
p(1:4*S(1, 1), :) = multiply([rand(S(1, 1), 2) zeros(S(1, 1), 1) ones(S(1, 1), 1) (1:4:4*S(1, 1))']);
j = 4*S(1, 1);
for g = 1:10 % set max generation number
    if any(p(1:j, 4) == g)
        p(1:j, 3) = p(1:j, 3) - max(p(p(:, 4) == g, 3));
        NB = calculate(g, p(1:j, :), S(1, :));
        [~, in] = sort(NB(:, 1));
        for i = in'
            p(1:j, 3) = p(1:j, 3) + NB(i, 1);
            NB(:, 1) = NB(:, 1) - NB(i, 1);
            p(j+1:j+4, :) = multiply([NB(i, 2:3) 0 g+1 j+1]);
            j = j + 4;
        end
        disp(['Rmin=' num2str(S(1, 2)) ' Rmax=' num2str(S(1, 3)) ' seed=' num2str(S(1, 4)) ' N(g=' num2str(g) ')=' num2str(sum(p(:, 4) == g)/4) ' time=' num2str(toc)]);
    end
end
p(j+1:end, :) = [];
%save(['Rmin' num2str(S(1, 2)*100) '-Rmax' num2str(S(1, 3)*100) '-' num2str(S(1, 4)) '.mat'], 'p');