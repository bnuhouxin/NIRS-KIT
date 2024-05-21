function drawBrain(Mat)

% Init
  
screen_size = get(0, 'ScreenSize');
screen_width = screen_size(3);
screen_height = screen_size(4);

figwidth = 1000;
Margin = 50;

gcfcolor = [0.2 0.2 0.2];
gcacolor = [0 0 0];
gridcolor = [1 1 1];

H = Mat;
scale = 69;
% colors = flipud(bone(scale));
colors = bone(scale);

center = mean(H, 1);
dist = round(DistBtw(center, H)) - 48;

% Visualization

figure; hold on;
for j = 1:scale
  index = dist == j;
  region = H(index, :);
  plot3(region(:,1), region(:,2), region(:,3), ...
        's', 'MarkerSize', 5, ...
        'Color', colors(j, :), 'MarkerFaceColor', colors(j, :));
end

set(gcf, 'color', gcfcolor);
figpos = get(gcf, 'position');
figpos(1) = Margin;
figpos(2) = screen_height - figpos(4) - Margin;
figpos(3) = figwidth;
set(gcf, 'position', figpos);

set(gca, 'color', gcacolor);
set(gca, 'XColor', gridcolor);
set(gca, 'YColor', gridcolor);
set(gca, 'ZColor', gridcolor);
% Set appropriate margin
set(gca, 'Units', 'Normalized', ...
         'Position', [0.1, 0.1, 0.5, 0.8]);
set(gca, 'Tag', 'MainCanvas');
grid on;

view(-37.5, 30);
axis equal vis3d;