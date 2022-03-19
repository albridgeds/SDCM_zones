function plot_multi_points(lat,long,zone_work)
% вывод кратности обслуживани€ дл€ произвольного числа  ј
% min_el - угол места, выше которого считаетс€ 




% рисование
%figure(1)

% максимальна€ кратность, нужна дл€ правильного отображени€ цветов
k = max(zone_work(:));

% цвета дл€ отображени€ кратности зон
cmap_r =  	[1.0, 0.8, 0.8];
cmap_rg =   [1.0, 1.0, 0.8];
cmap_g =    [0.8, 1.0, 0.8];
cmap_gb = 	[0.8, 1.0, 1.0];
%cmap_b = 	[0.8, 0.8, 1.0];   

% без покрыти€ - красный, с однократным покрытием - желтый
cmap = [cmap_r;cmap_rg];

% двукратное покрытие - зеленый цвет
if (k>1)
    cmap = [cmap;cmap_g];
end

% трехкратное и более - голубой цвет
for i=2:k-1
    cmap = [cmap;cmap_gb];
end


colormap(cmap)


contourfm(lat,long,zone_work,k+1,'LineStyle','none');
%contourcbar


end

