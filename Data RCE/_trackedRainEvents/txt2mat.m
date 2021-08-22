clc; clear; tic;
filenames = {'0.1_dx=200', '0.2_dx=200', '0.6_dx=200', '1_dx=200', '1_dx=1000', '1_dx=2000', '1_dx=4000'};
opts = delimitedTextImportOptions("NumVariables", 12);
opts.Delimiter = ["   ", "    ", "     ", "      ", "       "];
opts.VariableTypes = repmat("double", 1, 12);
opts.ConsecutiveDelimitersRule = "join";
opts.ExtraColumnsRule = "ignore";

A = [0.2 0.2 0.2 0.2 1 2 4].^2;

for i = 1:size(filenames, 2)
    p = table2array(readtable(['_txtDataFiles/Evap=' filenames{i} '.txt'], opts));
    p = p(~isnan(p(:, 7)), :);
    [~, ia] = unique(p(:, 2), 'first');
    p = [p(ia, [10 11 3]) accumarray(p(:, 2), p(:, 6).*p(:, 7)) histcounts(p(:, 2), 'BinMethod', 'integers')'];
    p(:, 4) = p(:, 4)*A(i);
    p(:, 3) = p(:, 3)/6;
    p(:, 1:2) = p(:, 1:2)-1;
    p(:, 1:2) = p(:, 1:2)/max(max(p(:, 1:2)));
    p = sortrows(p, 3);
    save(['_matDataFiles/Evap=' filenames{i} '.mat'], 'p');
end
toc;