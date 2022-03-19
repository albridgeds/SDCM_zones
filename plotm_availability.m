% расчет и вывод на карту кратности покрытия сигналами
function plotm_availability (satelite,user,min_mult)

% time - массив времен, для которых нужно произвести расчет (не нужно для ГЕО)
% satelite - названия спутников
% min_mult - необходимая кратность покрытия, для которой считается зона


% минимальный угол возвышения, по которому определяется зона
min_el = user.el;


time = 0:0.2:23.8;

% создание зоны, для которой ведется расчет
[lat,long] = zone_earth();

% количество КА
size_sat = size(satelite,2);

zone2 = zeros(size(lat));

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
        
        zone_work = zone_sum(zone_work,el,'>=',min_el);      % кратность покрытия с углом места больше минимального
    end
    
    zone_work = zone_work >= min_mult;                      % выполнение условия "однократное/двукратное покрытие"
    zone2 = zone_sum(zone2,zone_work);                      % складываем по времени
    
end
    

%     % расчет кратности покрытия территории РФ
%     [stat0,stat1,stat2,stat3] = multi_stat(lat,long,zone_work);
%     
%     % вывод статистики в текстовом виде
%     fprintf('\nSDCM zones for Russia:\n');
%     fprintf('zone x0 = %.1f%%\n',stat0);
%     fprintf('zone x1 = %.1f%% (%.1f%%)\n',stat1,stat1+stat2+stat3);
%     fprintf('zone x2 = %.1f%% (%.1f%%)\n',stat2,stat2+stat3);
%     fprintf('zone x3 = %.1f%%\n',stat3);
%     stat2 = stat2+stat3;
%     stat1 = stat1+stat2;


zone2 = zone2/length(time);
avail_stat_russia(lat,long,zone_work,0.9);
avail_stat_global(lat,long,zone_work,0.9);



%карта доступности с закрашенными зонами
worldmap = create_figure(45);
%color_multi(zone_work);         % выводим на печать кратность покрытия
colormap pink
contourfm(lat,long,zone2,0:0.1:1,'LineStyle','none');
contourcbar
%contourm(lat,long,zone2,[0.95 0.95],'LineColor','b');       % доступность по уровню 0.95
plot_map(worldmap);
plotm_orbit(0,satelite,'b'); 


% сохранение карты в файл
filename = sprintf('pictures\\availability.png');
print(worldmap,'-dpng',filename);


    
        





