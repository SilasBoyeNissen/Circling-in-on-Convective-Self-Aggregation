clear; close all; tic;

%% PARAMETERS
COLOR = [0.9 0.9 1; 0.8 0.8 1; 0.7 0.7 1; 0.6 0.6 1; 0.5 0.5 1; 0.4 0.4 1;  0.3 0.3 1;  0.2 0.2 1;   0.1 0.1 1;   0 0 1]; % the blue color scheme
SEED = 1; % the seed that was used as the random number generator
LRMAX = 4; % the value of the parameter L/Rmax
LRMIN = 50; % the value of the parameter L/Rmin
tSTART = 0; % the start of the movie on a logaritmic scale (10^-2 = 0.01)
tEND = 10; % the end of the movie on a logaritmic scale (10^1 = 10)
FRAMES = 101; % the number of frames of the movie

%% SCRIPT
load('../generated data/LRmin50-LRmax4-1'); % load the data file
p(:, 3) = p(:, 3) - max(p(:, 3)); % go back in time to the start of generation 1
figure(1); clf; % clear figure 1
set(figure(1), 'Color', 'w', 'Position', [0 0 900 920]); % set the window position and size
video = VideoWriter(['LRmin' num2str(LRMIN) '-LRmax' num2str(LRMAX) '-' num2str(SEED)], 'MPEG-4'); % set the name of the movie file
open(video);
g = 1; % generation 1
for DT = linspace(tSTART, tEND, FRAMES) % linearly spaced time
    clf;
    T = p + [0 0 DT 0 0]; % go to the current time point
    T(T(:, 3) < 0, :) = []; % delete all circles with negative radius (those did not appear yet)
    T(T(:, 3) > 0.5, :) = []; % delete all circles bigger than a radius of 1.5 (those span the entire domain)
    T((T(:, 1) > 1) + (T(:, 2) > 1) + (((T(:, 1)-1).^2 + (T(:, 2)-1).^2) > T(:, 3).^2) == 3, :) = [];
    T((T(:, 1) > 1) + (T(:, 2) < 0) + (((T(:, 1)-1).^2 + T(:, 2).^2) > T(:, 3).^2) == 3, :) = [];
    T((T(:, 1) < 0) + (T(:, 2) > 1) + ((T(:, 1).^2 + (T(:, 2)-1).^2) > T(:, 3).^2) == 3, :) = [];
    T((T(:, 1) < 0) + (T(:, 2) < 0) + ((T(:, 1).^2 + T(:, 2).^2) > T(:, 3).^2) == 3, :) = [];
    T((T(:, 1) < 0) + (T(:, 2) > 0) + (T(:, 2) < 1) + (abs(T(:, 1)) > T(:, 3)) == 4, :) = [];
    T((T(:, 2) < 0) + (T(:, 1) > 0) + (T(:, 1) < 1) + (abs(T(:, 2)) > T(:, 3)) == 4, :) = [];
    T((T(:, 1) > 1) + (T(:, 2) > 0) + (T(:, 2) < 1) + (T(:, 1)-1 > T(:, 3)) == 4, :) = [];
    T((T(:, 2) > 1) + (T(:, 1) > 0) + (T(:, 1) < 1) + (T(:, 2)-1 > T(:, 3)) == 4, :) = [];
    vis = find(T(:, 4) >= max(T(:, 4))-8)';
    V = T(vis, :);
    tightsubplot(1, 1, [0 0], [0.004 0.025], [0.004 0.003]); % set the properties of tightsubplot. See the tightsubplot file for details.
    rectangle('Position', [0 0 1 1], 'FaceColor', [1 1 1]); hold on; % set the background color
    for G = unique(V(:, 4))'
        t1 = find(V(:, 4) == G)';
        for i = t1
            rectangle('Position', [V(i, 1)-min(V(i, 3), 1/LRMAX) V(i, 2)-min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX)], ...
                'Curvature', [1 1], 'EdgeColor', 'k', 'LineWidth', 3);
        end
        for i = t1 % draw each circle as a rectangle with curvature [1 1] (that gives a circle)
            rectangle('Position', [V(i, 1)-min(V(i, 3), 1/LRMAX) V(i, 2)-min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX) 2*min(V(i, 3), 1/LRMAX)], ...
                'Curvature', [1 1], 'EdgeColor', 'none', 'FaceColor', COLOR(mod(V(i, 4)-1, 10)+1, :, 1));
        end
    end
    title(['Time = ' num2str(DT, 3)], 'FontSize', 20); % write the current time stamp above the domain
    set(gca, 'Box', 'on', 'LineWidth', 3); % draw a black edge around the domain
    axis([0 1 0 1], 'square'); % show only the domain
    writeVideo(video, getframe(gcf)); % write the current frame to the movie file
end
close(video);
toc;