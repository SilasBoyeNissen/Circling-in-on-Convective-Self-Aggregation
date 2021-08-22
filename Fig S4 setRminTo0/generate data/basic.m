clear; close all;
C = [1 0 0 100]; % P2 P3 Rmin Rmax
N = 100;
for seed = 1:20
    tic; rng(seed);
    S = multiply([rand(N, 2) zeros(N, 1) ones(N, 1) (1:4:4*N)']);
    save(['../generated mat-files/S' num2str(N) '-' num2str(seed)], 'S');
end
for g = 1:12
    for seed = 1:20
        tic;
        load(['../generated mat-files/S' num2str(N) '-' num2str(seed)]);
        if any(S(:, 4) == g)
            c = 1;
            col = zeros(100000, 2);
            S(:, 3) = S(:, 3) - max(S(S(:, 4) == g, 3));
            NB = neighbor(C, S, find(S(:, 4) == g), S(S(:, 4) == g, :));
            [~, in] = sort(NB(:, 1));
            for I = in'
                [dr, T] = cp2cols(NB(I, 3:4), S);
                if ~isnan(dr)
                    S(:, 3) = S(:, 3) + dr;
                    ijk = sort([S(NB(I, 3), 5) S(NB(I, 4), 5)]);
                    if ~ismember(ijk, col, 'rows')
                        S = [S; multiply(T)];
                    end
                    col(c, :) = ijk;
                    c = c + 1;
                end
            end
            save(['../generated mat-files/S' num2str(N) '-' num2str(seed)], 'S');
            disp(['N=' num2str(N) ' #gen=' num2str(max(S(:, 4))) ' seed=' num2str(seed, '%02.0f') ': #circ=' num2str(sum(S(:, 4) == g)/4) ' time=' num2str(toc)]);
        end
    end
end