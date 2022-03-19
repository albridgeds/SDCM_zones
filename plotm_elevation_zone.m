function plotm_elevation_zone (time,satelite,user)
% расчет мощности сигнала КА для зоны в произвольные моменты времени

% mode=0 - отдельная карта для каждого КА
% mode=1 - суммарная карта для всех КА
% mode=2 - отдельные и суммарная карта

[lat,long] = zone_earth();

size_lat = size(lat,1);
size_long = size(lat,2);
satlen = length(satelite);

zone = zeros(size_lat,size_long,satlen);




% перебираем время (т.к. позиция КА меняется, если это не ГСО)
for time_=time

    %t = time_index(time_);
    
    % по очереди перебираем спутники
    for s=1:satlen

        sat = satelite(s);
        orbit = sat.orbit;
        
        % угол места, расстояние и 
        zone_e = calc_elevation(lat,long,orbit,user.h);

        % сохраняем для использования в другие моменты времени и формирования суммарной карты
        zone(:,:,s) = zone_e;

        
        
        % если режим печати только суммарной карты, переходим к следующему спутнику
%         if mode==1
%             continue;
%         end
        
        
%         worldmap = create_figure(46);
%         %plot_power(lat,long,zone_p,signal)
%         %plot_power(lat,long,zone_p,receiver.channel)
% 
%         % радиовидимость
%         min_el = receiver.el;
%         contourm(lat,long,el,[min_el min_el],'-b','LineWidth',2);
% 
%         % трассы спутников
%         plot_orbit(orbit,t,1);
% 
%         s_title = sprintf('%s %s %02gh (Teta=%g, P=%dW)',sat.name,signal,time_,Teta_05,channel.Ptx);
%         %title(['Power: ',signal,' time ',time,'h']);
%         title(s_title)
% 
%         % сохранение карты в файл
%         plot_map(worldmap);
%         filename = sprintf('pictures\\m_elevation_%s',sat.name);
%         if ~strcmp(sat.type,'GEO')
%             filename = sprintf('%s_%02g',filename,time_);
%         end
%         filename = [filename,'.png'];
%         print(worldmap,'-dpng',filename);
%         fprintf('\ncreate file <%s>',filename);

    end

    
    % печать суммарной карты (если больше одного КА и в соответствующем режиме)
    if satlen>1
        sum_zone = max(zone(:,:,1),zone(:,:,2));
        for s=3:satlen
            sum_zone = max(sum_zone,zone(:,:,s));
        end
        
        worldmap = create_figure(45);
        
        %colormap pink
        %contourfm(lat,long,sum_zone,5:15:50,'LineStyle','none');
        contourm(lat,long,sum_zone,0:10:90);
        contourcbar
        
        for s=1:satlen
            plotm_orbit(-1,satelite(s));
        end        
        %s_title = sprintf('%s %s %02gh (Teta=%g, P=%dW)',sat.name,signal,time_,Teta_05,channel.Ptx);
        %title(s_title)
        plot_map(worldmap);
        filename = sprintf('pictures\\map_elevation.png');
        print(worldmap,'-dpng',filename);
        fprintf('\ncreate file <%s>',filename);
    end
    
end



