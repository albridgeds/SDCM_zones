function plotm_satzones (time,satelite,user)


[lat,long] = zone_earth();

size_lat = size(lat,1);
size_long = size(lat,2);
satlen = length(satelite);

zone = zeros(size_lat,size_long,satlen);


% перебираем время (т.к. позиция КА меняется, если это не ГСО)
for time_=time
   
    % по очереди перебираем спутники
    for s=1:satlen

        sat = satelite(s);
        orbit = sat.orbit;
        
        % угол места, расстояние и 
        zone_e = calc_elevation(lat,long,orbit,user.h);

        % сохраняем для использования в другие моменты времени и формирования суммарной карты
        zone(:,:,s) = zone_e;
    end

    satzone = zeros(size_lat,size_long);
    for i=1:size_lat
       for j=1:size_long 
            [maxel,satid] = max(zone(i,j,:));
            if (maxel>5)
                satzone(i,j) = satid;
            end
       end
    end
        

    worldmap = create_figure(45);

    %colormap pink
    colormap summer
    contourfm(lat,long,satzone,'LineStyle','none');
    contourcbar

    for s=1:satlen
        plotm_elevation(-1,satelite(s));
        plotm_orbit(-1,satelite(s));
    end

     plot_map(worldmap);
%     filename = sprintf('pictures\\map_elevation.png');
%     print(worldmap,'-dpng',filename);
%     fprintf('\ncreate file <%s>',filename);

%city = create_city_array('Владивосток','Петропавловск','Иркутск','Чернышевский','Тикси','Провидения','Тында','Певек','Южно-Сахалинск','Чокурдах');         % для Луч-5A
%city = create_city_array('Москва','Мурманск','Калининград','Севастополь','Дербент','Самара');                                                               % для Луч-5Б
city = create_city_array('Москва','Ростов','Архангельск','Оренбург','Кызыл-Озек','Кармакулы','Диксон','Баранова','Дербент','Иркутск','Тикси','Благовещенск','Ханты-Мансийск','Чернышевский');       % для Луч-5В
for i = 1:length(city)
    plotm(city(i).lat,city(i).long,'or')
end
    
    
end