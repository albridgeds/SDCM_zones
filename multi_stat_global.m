function [zone0,zone1,zone2,zone3] = multi_stat_global(lat,long,zone)


% карта с точками (для контроля закрытия территории)
point_map = 0;


pi=3.1415926535;
Llong = 20004.274/180;                      % длина дуги в 1 градус по меридиану (км)


size_lat = size(zone,1);
size_long = size(zone,2);


count0 = 0;
count1 = 0;
count2 = 0;
count3 = 0;


if (point_map) 
    worldmap = create_figure(44);
end


% просмотр всех точек зоны, для которых во внешней функции проведен расчет многократности покрытия (вся Земля с шагом 1 градус)
for i=1:size_lat
    
    Llat = 111.3*cos(lat(i,1)*pi/180);      % длина дуги в 1 градус по параллели на заданной широте (км)
    S1 = Llong*Llat;                      % элемент площади на текущей широте
        
    for j = 1:size_long
        if (zone(i,j)==0)
            count0 = count0+S1;
            if (point_map) plotm(lat(i,j),long(i,j),'.r'); end
        elseif (zone(i,j)==1)
            count1 = count1+S1;
            if (point_map) plotm(lat(i,j),long(i,j),'.y'); end
        elseif (zone(i,j)==2)
            count2 = count2+S1;
            if (point_map) plotm(lat(i,j),long(i,j),'.g'); end
        elseif (zone(i,j)>=3)
            count3 = count3+S1;
            if (point_map) plotm(lat(i,j),long(i,j),'.b'); end
        end
    end
end

count_total = count0 + count1 + count2 + count3;    % площадь России по Вики - 17,1 млн км2, тут получается 17,6 млн км2 (Земли: 510,1 и 511.7 млн км2 соответственно)


zone0 = count0/count_total*100;
zone1 = count1/count_total*100;
zone2 = count2/count_total*100;
zone3 = count3/count_total*100;

if (point_map)
	plot_map(worldmap);
	print(worldmap,'-dpng','pictures\\multi_points.png');
end


% вывод статистики в текстовом виде
fprintf('\nGlobal visibility zones:\n');
fprintf('zone x0 = %.1f%%\n',zone0);
fprintf('zone x1 = %.1f%% (%.1f%%)\n',zone1,zone1+zone2+zone3);
fprintf('zone x2 = %.1f%% (%.1f%%)\n',zone2,zone2+zone3);
fprintf('zone x3 = %.1f%%\n',zone3);

end

