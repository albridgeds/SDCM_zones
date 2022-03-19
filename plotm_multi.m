% расчет и вывод на карту кратности покрытия сигналами
function plotm_multi (time,satelite,user,min_el,satcolor)

% time - массив времен, для которых нужно произвести расчет (не нужно для ГЕО)
% satelite - названия спутников
% min_el - угол возвышения, по которому определяется зона




% создание зоны, для которой ведется расчет
[lat,long] = zone_earth();

% количество КА
size_sat = size(satelite,2);



for time_=time

    zone_work = zeros(size(lat));
    
    for i=1:size_sat
        
        if strcmp(satelite(i).name,'none')   % если нет данных, пропускаем этот КА
            continue
        end  
        
        orbit = satelite(i).orbit;
       
        if (size(orbit,1)>1)    % если орбита задана в виде массива точек во времени (не ГСО)
            t = time_index(time_,orbit);
            orbit = orbit(t,:);
        end
        
        el = calc_elevation(lat,long,orbit,user.h);                % быстрый расчет угла места для текущего КА
        
        % проверка для ВКК, не вышел ли КА за пределы рабочей зоны
        if ~orbit_checkWorkzone(satelite(i),orbit)
            el = zeros(size(lat))-1000;         % угол места ставим отрицательным, чтобы не учитывать этот КА в суммарной зоне покрытия
        end
        
        zone_work = zone_sum(zone_work,el,'>=',min_el);     % объединение зон видимости
    end
    
    


    % карта с закрашенными зонами
    worldmap = create_figure(45);
    color_multi(zone_work);         % выводим на печать кратность покрытия
    
    k = max(zone_work(:));
    contourfm(lat,long,zone_work,k+1,'LineStyle','none');
    
    plotm_elevation(time_,satelite,user,satcolor,min_el);      % подумать: углы места уже рассчитывались ранее, но не можем здесь нарисовать контуры, так как цикл уже прошел 
    plot_map(worldmap);
    
    
    % расчет кратности покрытия территории РФ
    [stat0,stat1,stat2,stat3] = multi_stat(lat,long,zone_work);    
	s_title = sprintf('SDCM zones for Russia: 1x - %.1f%%, 2x - %.1f%%, 3x - %.1f%%',stat1+stat2+stat3,stat2+stat3,stat3);
    %s_title = sprintf('%s\n111',s_title);
    xlabel(s_title)
 
    
    % сохранение карты в файл
    filename = sprintf('pictures\\multi_t%02g.png',time_);
    print(worldmap,'-dpng',filename);
    
    % расчет кратности глобального покрытия
    multi_stat_global(lat,long,zone_work);
    
    
end




end

