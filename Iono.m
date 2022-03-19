clc
clf
clear

satnum = [1:13,15:25];
satnum1 = [7:9,15:19];
satnum2 = [1,2,5,6,13,22,24,25];
satnum3 = [3,4,10:12,20,21,23];

% печать зоны обслуживания геостационара
satelite = create_sat_array('5V');
user.h = 0;
plotm_elevation(0,satelite,user,'g',5,'newmap');

% период расчета - часы от начала суток, следующих за эпохой TLE
%time = 0:60*10:3600*24;         % для GPS - сутки с шагом 10 минут
time = 0:60*60:3600*24*7;         % для ГЛОНАСС - неделя с шагом 1 час

% орбтальная группировка ГНСС
%satelite = create_sat_system(time,'GPS',1:30);
satelite = create_sat_system(time,'GLO',satnum);
%plotm_orbit(-1,satelite,'b')


%city = create_city_array('Владивосток','Петропавловск','Иркутск','Чернышевский','Тикси','Провидения','Тында','Певек','Южно-Сахалинск','Чокурдах');         % для Луч-5A
%city = create_city_array('Москва','Мурманск','Калининград','Севастополь','Дербент','Самара');                                                               % для Луч-5Б
city = create_city_array('Москва','Ростов','Архангельск','Оренбург','Кызыл-Озек','Кармакулы','Диксон','Баранова','Дербент','Иркутск','Тикси','Благовещенск','Ханты-Мансийск','Чернышевский');       % для Луч-5В
for i = 1:length(city)
    plotm(city(i).lat,city(i).long,'or')
end

% задаем ионосферную сетку для выбранных зон (для России это 0,4-8 и 9)
[ionogrid_lat,ionogrid_long] = create_ionogrid([0,4:9]);      % [0,4:9]
ionogrid = zeros(1,length(ionogrid_lat));
%plotm(ionogrid_lat,ionogrid_long,'.b')


%return


% перебираем по очереди все моменты времени
for t = 1:length(time)
    
    % создаем снимок ионосферной сетки для текущего момента времени
    %tmp_ionogrid = zeros(length(ionogrid_lat),length(ionogrid_long));
    tmp_ionogrid = zeros(1,length(ionogrid_lat));
    
    % перебираем все точки на поверхности
    for c = 1:length(city)

        lat_r = city(c).lat;
        long_r = city(c).long;
    
        % перебираем все спутники
        for s=1:length(satelite)

            % координаты точки прокола для данного спутника на текущий момент времени
            [lat_ipp,long_ipp] = ipp_calc(lat_r,long_r,satelite(s).orbit(t,:));
            %plotm(lat_ipp,long_ipp,'xr')

            % если нет точки прокола, пропускаем
            if lat_ipp >= 1000.0
                continue
            end

            % ближайшие точки сетки севернее прокола
            delta_lat = ionogrid_lat-lat_ipp + (ionogrid_lat<=lat_ipp)*1000;	% разница широты с отсечкой для точек южнее прокола
            [lat,idlat] = min(delta_lat);                                       % индекс самой близкой точки сетки по широте севернее прокола (только одной)
            idlat = find(ionogrid_lat==ionogrid_lat(idlat));                    % индекс всех самых близких точек сетки по широте севернее прокола
            
            % ближайшая точка сетки к северо-востоку от прокола
            delta_long = ionogrid_long(idlat)-long_ipp + (ionogrid_long(idlat)<=long_ipp)*1000; 	% разница долготы с отсечкой для точек западнее прокола
            [~,idlong] = min(delta_long);                                                           % индекс самой близкой точки сетки по долготе восточнее прокола (из числа ближайших к северу)
            id1 = idlat(idlong);                                                                    % индекс ближайшей точки к северо-востоку от прокола в исходном массиве
            %plotm(ionogrid_lat(id1),ionogrid_long(id1),'.g')
            tmp_ionogrid(id1) = tmp_ionogrid(id1)+1;
            
            % ближайшая точка сетки к северо-западу от прокола
            delta_long = long_ipp-ionogrid_long(idlat) + (ionogrid_long(idlat)>=long_ipp)*1000; 	% разница долготы с отсечкой для точек восточнее прокола
            [~,idlong] = min(delta_long);
            id2 = idlat(idlong);
            %plotm(ionogrid_lat(id2),ionogrid_long(id2),'.c')
            tmp_ionogrid(id2) = tmp_ionogrid(id2)+1;            
            
            % ближайшие точки сетки южнее прокола
            delta_lat = lat_ipp-ionogrid_lat + (ionogrid_lat>=lat_ipp)*1000;    % разница широты с отсечкой для точек севернее прокола
            [lat1,idlat] = min(delta_lat);                                      % индекс самой близкой точки сетки по широте южнее прокола (только одной)
            idlat = find(ionogrid_lat==ionogrid_lat(idlat));                    % индекс всех самых близких точек сетки по широте южнее прокола

            % ближайшая точка сетки к юго-востоку от прокола
            delta_long = ionogrid_long(idlat)-long_ipp + (ionogrid_long(idlat)<=long_ipp)*1000; 	% разница долготы с отсечкой для точек западнее прокола
            [~,idlong] = min(delta_long);
            id3 = idlat(idlong);
            %plotm(ionogrid_lat(id3),ionogrid_long(id3),'.r')
            tmp_ionogrid(id3) = tmp_ionogrid(id3)+1;
            
            % ближайшая точка сетки к юго-западу от прокола
            delta_long = long_ipp-ionogrid_long(idlat) + (ionogrid_long(idlat)>=long_ipp)*1000; 	% разница долготы с отсечкой для точек восточнее прокола
            [~,idlong] = min(delta_long);
            id4 = idlat(idlong);
            %plotm(ionogrid_lat(id4),ionogrid_long(id4),'.m')
            tmp_ionogrid(id4) = tmp_ionogrid(id4)+1;

        end
    end
    
    % если точка ионосферной сетки была задействована хоть для одного прокола в текущий момент времени, переписываем ее
    ionogrid = ionogrid + (tmp_ionogrid>0);     
end



% вычисление и печать вероятности использования точки ионосферной сетки
ionogrid = ionogrid/length(time);

amount0 = 0;
amount10 = 0;
amount20 = 0;
amount30 = 0;
amount40 = 0;
amount50 = 0;

for i=1:length(ionogrid_lat)
    iono = ionogrid(i);
    if iono>0
        if iono>0.5
            color = '.m';
            amount50 = amount50+1;
        elseif iono>0.4
            color = '.r';
            amount40 = amount40+1;
        elseif iono>0.3
            color = '.y';
            amount30 = amount30+1;
        elseif iono>0.2
            color = '.g';
            amount20 = amount20+1;
        elseif iono>0.1
            color = '.c';
            amount10 = amount10+1;
        elseif iono>0
            color = '.b';
            amount0 = amount0+1;
        end
        plotm(ionogrid_lat(i),ionogrid_long(i),color)
    end
end

amount40 = amount40 + amount50;
amount30 = amount30 + amount40;
amount20 = amount20 + amount30;
amount10 = amount10 + amount20;
amount0 = amount0 + amount10;

fprintf('\n\nТочек сетки, используемых:')
fprintf('\n- хотя бы один раз - %d',amount0)
fprintf('\n- не менее 10%% времени - %d',amount10)
fprintf('\n- не менее 20%% времени - %d',amount20)
fprintf('\n- не менее 30%% времени - %d',amount30)
fprintf('\n- не менее 40%% времени - %d',amount40)
fprintf('\n- не менее 50%% времени - %d',amount50)

str = sprintf('>0%% - %d',amount0);
str = strcat(str,sprintf('\n>10%% - %d',amount10));
str = strcat(str,sprintf('\n>20%% - %d',amount20));
str = strcat(str,sprintf('\n>30%% - %d',amount30));
str = strcat(str,sprintf('\n>40%% - %d',amount40));
str = strcat(str,sprintf('\n>50%% - %d',amount50));

text(-1.75,-0.26,str,'EdgeColor','k','BackgroundColor','w');

