clear; close all; tic;
C = [3000 0.008 0.04 0.001 0]; % N Rmin Rmax dr P
for seed = 1:5
    rng(seed);
    S = multiply([rand(C(1), 2) zeros(C(1), 1) ones(C(1), 1) (1:4:4*C(1))' (-1:-1:-C(1))' (-1:-1:-C(1))']);
    for G = 1:1000
        if any(S(:, 4) == G)
            col = ones(0, 2);
            S(:, 3) = S(:, 3) - max(S(S(:, 4) == G, 3));
            NB = neighbor(C, G, S);
            [~, in] = sort(NB(:, 1));
            for i = in'
                S(:, 3) = S(:, 3) + NB(i, 1);
                NB(:, 1) = NB(:, 1) - NB(i, 1);
                nbs = NB(i, 2:3);
                ijk = zeros(1, 2);
                ijk(nbs>0) = S(nbs(nbs>0), 5);
                if all(sum((col == ijk(1)) + (col == ijk(2)), 2) < 2)
                    S = [S; multiply([NB(i, 4:5) 0 G+1 size(S, 1)+1 S(NB(i, 2:3), 5)'])];
                    if NB(i, 6) == NB(i, 7)
                        col(end+1, :) = ijk;
                    end
                end
            end
            disp(['N=' num2str(C(1)) ' seed=' num2str(seed) ' gen=' num2str(G) ': #circ=' num2str(sum(S(:, 4) == G)/4) ' time=' num2str(toc)]);
        end
    end
	save(['N' num2str(C(1)) '-Rmin' num2str(C(2)*1000) '-Rmax' num2str(C(3)*1000) '-P' num2str(C(5)*10) '-seed' num2str(seed)], 'S');
end