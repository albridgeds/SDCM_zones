function plotm_power (time,satelite,channel,receiver,mode)
% расчет мощности сигнала КА для зоны в произвольные моменты времени

% mode=0 - отдельная карта для каждого КА
% mode=1 - суммарная карта для всех КА
% mode=2 - отдельные и суммарная карта

[lat,long] = zone_earth();

size_lat = size(lat,1);
size_long = size(lat,2);



satlen = length(satelite);
satzone_flag = zeros(1,satlen);




% перебираем время (т.к. позиция КА меняется, если это не ГСО)
for time_=time

    % по очереди перебираем спутники
    for s=1:satlen

        if strcmp(satelite(s).name,'none')   % если нет данных, пропускаем этот КА
            continue
        end
        
        sat = satelite(s);
%         chanlen = length(sat.channel);
% 
%         % находим у спутника канал, работающий с нужным сигналом
%         channel_flag=0;
%         for c=1:chanlen
%             satchannel = sat.channel(c).signal;
%             if (strcmp(satchannel,signal))
%                 channel_flag=1;
%                 channel = sat.channel(c);
%             end
%         end
    
       
        % если такого канала нет, пропускаем этот спутник
%         if channel_flag==0
%              fprintf('\n\nWARNING: satelite <%s> has no <%s> channel',satelite(s).name,signal);
%              continue;
%         end

        % если это ГСО и для него уже есть расчет, то повторять не нужно
        if strcmp(sat.type,'GEO') && satzone_flag(s)~=0
            continue;
        end
        
        orbit = sat.orbit;
        if (size(orbit,1)>1)    % если орбита задана в виде массива точек во времени (не ГСО)
            t = time_index(time_,orbit);
            orbit = orbit(t,:);
        end
        
        % угол места, расстояние и 
        %[el,~,r,phi] = calc_geometry (lat,long,orbit,channel.angle2north,channel.angle2east,receiver.h);
        [el,~,r,phi] = calc_geometry (lat,long,orbit,sat.angle2north,sat.angle2east,receiver.h);
        
        
        % расчет мощности в зоне
        zone_p = zeros(size(lat)) - receiver.Pmin;          % КОСТЫЛЬ!!! надо перенести сюда расчет, учитываяющий тип сигнала и потребителя
        if orbit_checkWorkzone(sat,orbit)       % только если КА в рабочей зоне
            for i=1:size_lat
                for j=1:size_long
                    zone_p(i,j) = calc_power(el(i,j),r(i,j),phi(i,j),channel,receiver);
                end
            end
        end

        % сохраняем для использования в другие моменты времени и формирования суммарной карты
        zone(:,:,s) = zone_p;
        satzone_flag(s)=1;
        
        
        % если режим печати только суммарной карты, переходим к следующему спутнику
        if satlen>1 && mode==1 
            continue;
        end
        
        % если спутник за пределами рабочей зоны, переходим к следующему
        if ~orbit_checkWorkzone(sat,orbit)
            continue;
        end
        
        worldmap = create_figure(45);
        powers = color_power(zone_p,receiver);      %%% это фактически цвет!
        
        % вывод уровня мощности сигналов
        contourfm(lat,long,zone_p,powers,'LineStyle','none');
        contourcbar
        contourm(lat,long,zone_p,[receiver.Pmax receiver.Pmax],'LineColor','r','LineWidth',2);
        
        contourm(lat,long,zone_p,[receiver.Plim receiver.Plim],'LineColor','.b','LineWidth',2);
        
        %if strcmp(channel.signal,'L3Sigal')
        %    contourm(lat,long,zone_p,[-155.3 -155.3],'LineColor','.b','LineWidth',2);
        %end

        % радиовидимость
        min_el = receiver.el;
        contourm(lat,long,el,[min_el min_el],'-b','LineWidth',1);

        % трассы спутников
        plotm_orbit(time_,satelite(s));

        s_title = sprintf('%s %s %02gh (P=%dW)',sat.name,channel.signal,time_,channel.Ptx);
        %title(['Power: ',signal,' time ',time,'h']);
        title(s_title)

        % сохранение карты в файл
        plot_map(worldmap);
        filename = sprintf('pictures\\power_%s',sat.name);
        if ~strcmp(sat.type,'GEO')
            filename = sprintf('%s_%02g',filename,time_);
        end
        filename = [filename,'.png'];
        print(worldmap,'-dpng',filename);
        fprintf('\ncreate file <%s>',filename);

    end

    
    % печать суммарной карты (если больше одного КА и в соответствующем режиме)
    if satlen>1 && mode>0
        sum_zone = max(zone(:,:,1),zone(:,:,2));
        for s=3:satlen
            sum_zone = max(sum_zone,zone(:,:,s));
        end
        
        worldmap = create_figure(45);
        %plot_power(lat,long,sum_zone,channel.signal)
        
        % вывод уровня мощности сигналов
        powers = color_power(sum_zone,receiver);
        contourfm(lat,long,sum_zone,powers,'LineStyle','none');
        contourcbar
        
        for s=1:satlen
            %el = zone_elevation(lat,long,satelite(s).orbit);
            %contourm(lat,long,el,[5 5],'-b','LineWidth',2);
            plotm_orbit(time_,satelite);
        end        
        s_title = sprintf('%s %02gh',channel.signal,time_);
        title(s_title)
        plot_map(worldmap);
        filename = sprintf('pictures\\powers');
         if ~strcmp(sat.type,'GEO')
            filename = sprintf('%s_%02g',filename,time_);
        end
        filename = [filename,'.png'];
        print(worldmap,'-dpng',filename);
        fprintf('\ncreate file <%s>',filename);
    end
    
end



