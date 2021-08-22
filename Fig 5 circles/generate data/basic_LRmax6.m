clear; close all;
LRmax = 6;
runs = 200;
gmax = 500;
for LRmin = 20:10:100
    q = zeros(gmax, runs); rng(1);
    S = [repmat([round(LRmin^2/10) 1/LRmin 1/LRmax], runs, 1) (1:runs)']; % N Rmin Rmax seed
    parfor s = 1:size(S, 1)
        rng(S(s, 4)); tic;
        p = zeros(1e7, 5);
        p(1:4*S(s, 1), :) = multiply([rand(S(s, 1), 2) zeros(S(s, 1), 1) ones(S(s, 1), 1) (1:4:4*S(s, 1))']);
        j = 4*S(s, 1);
        for g = 1:gmax
            if any(p(1:j, 4) == g)
                p(1:j, 3) = p(1:j, 3) - max(p(p(:, 4) == g, 3));
                NB = calculate(g, p(1:j, :), S(s, :));
                [~, in] = sort(NB(:, 1));
                for i = in'
                    p(1:j, 3) = p(1:j, 3) + NB(i, 1);
                    NB(:, 1) = NB(:, 1) - NB(i, 1);
                    p(j+1:j+4, :) = multiply([NB(i, 2:3) 0 g+1 j+1]);
                    j = j + 4;
                end
                disp(['LRmin=' num2str(LRmin) ' LRmax=' num2str(LRmax) ' seed=' num2str(S(s, 4)) ' N(g=' num2str(g) ')=' num2str(sum(p(:, 4) == g)/4) ' time=' num2str(toc)]);
            else
                break
            end
        end
        q(:, s) = histcounts(p(1:4:j, 4), 0.5:gmax+0.5)';
    end
    save(['../generated data/LRmin' num2str(LRmin) '-LRmax' num2str(LRmax) '.mat'], 'q');
end