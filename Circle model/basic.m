clear; close all; tic;

%% PARAMETERS
RminL = 0.05; % specify Rmin/L
RmaxL = 0.2; % specify Rmax/L
N1 = 100; % specify the initial number of circles
gmax = 100; % set an upper bound on the number of generations to run

%% SCRIPT
j = 4*N1; % total number of circles in the system including four replicas to ensure double-periodic boundary conditions
p = zeros(1e7, 5); % preset the system matrix, each row is a circle with the properties [X-position Y-position Radius Generation ReplicaID]
p(1:4*N1, :) = multiply([rand(N1, 2) zeros(N1, 1) ones(N1, 1) (1:4:4*N1)']); % the initial conditions: locations are random, radii are 0, generations are 1
for g = 1:gmax % generations to run
    if any(p(1:j, 4) == g) % only if any circles of that generation are present in the system
        p(1:j, 3) = p(1:j, 3) - max(p(p(:, 4) == g, 3)); % go back in time to the first circle of the current generation
        NB = calculate(g, p(1:j, :), RminL, RmaxL); % calculates the location and time of all circles belonging to the subsequent generation
        [~, in] = sort(NB(:, 1)); % sort the new circles in the order as they appear
        for i = in' % loop over all new circles
            p(1:j, 3) = p(1:j, 3) + NB(i, 1); % all circles in the system grow with the distance to the new circle
            NB(:, 1) = NB(:, 1) - NB(i, 1); % the distance to all future circles shrink with the same amount
            p(j+1:j+4, :) = multiply([NB(i, 2:3) 0 g+1 j+1]); % make four replicas of the newly inserted circle
            j = j + 4; % add four to the total number of circles in the system including replicas
        end
        disp(['RminL=' num2str(RminL) ' RmaxL=' num2str(RmaxL) ' N(g=' num2str(g) ')=' num2str(sum(p(:, 4) == g)/4) ' time=' num2str(toc)]); % display the status of the system
    end
end
p(j+1:end, :) = []; % deletes unused rows in the system matrix
save(['RminL=' num2str(RminL*100) ' RmaxL=' num2str(RmaxL*100) ' N1=' num2str(N1) '.mat'], 'p'); % saves the system matrix