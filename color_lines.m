function color = color_lines(step)
%COLOR_LINES Summary of this function goes here
%   Detailed explanation goes here



cmap = colormap;                        % запоминаем текущую палитру
cmap2 = colormap(lines);                % назначаем палитиру с сильно отличающимися цветами (по идее можно сделать и свою специальную палитру)

color = cmap2(step,:);

colormap(cmap);                         % возвращаем изначальную палитру


end

