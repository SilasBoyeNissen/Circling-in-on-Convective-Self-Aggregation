figure(1); clf; tic; NoCol = 5;
set(figure(1), 'Color', 'w', 'Position', [0 0 940 940]);
fig = tightsubplot(5, NoCol, [-0.01 -0.01], [-0.005 0], [0.003 -0.005]);

NC1 = ncread('../Data RCE/full_evap_300K_200m_Aug30.out.vol.q.LEV50.nc', 'q');
NC2 = ncread('../Data RCE/rem06Evap.out.vol.q.LEV50.nc', 'q');
NC3 = ncread('../Data RCE/rem02Evap.out.vol.q.LEV50.nc', 'q');
NC4 = ncread('../Data RCE/rem01Evap.out.vol.q.LEV50.nc', 'q');
NC5 = ncread('../Data RCE/removeEvap.out.vol.q.LEV50.nc', 'q');
RAW1 = reshape(NC1, size(NC1, 2), size(NC1, 3), size(NC1, 4));
RAW2 = reshape(NC2, size(NC2, 2), size(NC2, 3), size(NC2, 4));
RAW3 = reshape(NC3, size(NC3, 2), size(NC3, 3), size(NC3, 4));
RAW4 = reshape(NC4, size(NC4, 2), size(NC4, 3), size(NC4, 4));
RAW5 = reshape(NC5, size(NC5, 2), size(NC5, 3), size(NC5, 4));
Xmin = min([min(RAW1(:)) min(RAW2(:)) min(RAW3(:)) min(RAW4(:)) min(RAW5(:))]);
Xmax = max([max(RAW1(:)) max(RAW2(:)) max(RAW3(:)) max(RAW4(:)) max(RAW5(:))]);
BW1 = rot90((RAW1 - Xmin) ./ (Xmax - Xmin));
BW2 = rot90((RAW2 - Xmin) ./ (Xmax - Xmin));
BW3 = rot90((RAW3 - Xmin) ./ (Xmax - Xmin));
BW4 = rot90((RAW4 - Xmin) ./ (Xmax - Xmin));
BW5 = rot90((RAW5 - Xmin) ./ (Xmax - Xmin));
A1 = BW1(:, :, 6*24:6*24:end);
A2 = BW2(:, :, 6*24:6*24:end);
A3 = BW3(:, :, 6*24:6*24:end);
A4 = BW4(:, :, 6*24:6*24:end);
A5 = BW5(:, :, 6*24:6*24:end);

j = 1;
for i = 1:NoCol
    set(gcf, 'CurrentAxes', fig(j)); hold on;
    axis off;
    if i <= size(A1, 3)
        imshow(A1(:, :, i), 'Border', 'tight');
        rectangle('position', [0 0 size(BW1, 1) size(BW1, 2)], 'EdgeColor', [0 0 0], 'LineWidth', 2);
        colormap('gray');
    end
    j = j + 1;
end
for i = 1:NoCol
    set(gcf, 'CurrentAxes', fig(j)); hold on;
    axis off;
    if i <= size(A2, 3)
        imshow(A2(:, :, i), 'Border', 'tight');
        rectangle('position', [0 0 size(BW1, 1) size(BW1, 2)], 'EdgeColor', [0 0 0], 'LineWidth', 2);
        colormap('gray');
    end
    j = j + 1;
end
for i = 1:NoCol
    set(gcf, 'CurrentAxes', fig(j)); hold on;
    axis off;
    if i <= size(A3, 3)
        imshow(A3(:, :, i), 'Border', 'tight');
        rectangle('position', [0 0 size(BW1, 1) size(BW1, 2)], 'EdgeColor', [0 0 0], 'LineWidth', 2);
        colormap('gray');
    end
    j = j + 1;
end
for i = 1:NoCol
    set(gcf, 'CurrentAxes', fig(j)); hold on;
    axis off;
    if i <= size(A4, 3)
        imshow(A4(:, :, i), 'Border', 'tight');
        rectangle('position', [0 0 size(BW1, 1) size(BW1, 2)], 'EdgeColor', [0 0 0], 'LineWidth', 2);
        colormap('gray');
    end
    j = j + 1;
end
for i = 1:NoCol
    set(gcf, 'CurrentAxes', fig(j)); hold on;
    axis off;
    if i <= size(A5, 3)
        imshow(A5(:, :, i), 'Border', 'tight');
        rectangle('position', [0 0 size(BW1, 1) size(BW1, 2)], 'EdgeColor', [0 0 0], 'LineWidth', 2);
        colormap('gray');
    end
    j = j + 1;
end
%saveas(figure(1), 'Fig1.png');
toc;