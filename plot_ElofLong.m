function plot_ElofLong (time,satelite,user)
% угол возвышения КА в зависимости от долготы потребителя (при
% фиксированной широте)

    lat = 45;
    long = 0:180;

size_sat = length(satelite);

for time_=time
    
    figure();
    hold on
    grid on;
    xlim([long(1) long(end)]);
    ylim([0 100]);
    set(gca, 'xtick',0:10:180)
    set(gca, 'ytick',0:10:100)
    xlabel('Longitude, degree');
    ylabel('Elevation, degree');
    
    for i=1:size_sat
        orbit = satelite(i).orbit;
        
        if (orbit==0)   % если нет орбиты, пропускаем этот КА
            continue
        end
        
        if (size(orbit,1)>1)    % если орбита задана в виде массива точек во времени (не ГСО)
            t = time_index(time_);
            orbit = orbit(t,:);
        end
        
        el = calc_elevation(lat,long,orbit,user.h);                % быстрый расчет угла места
        
        plot(long,el)
        
    end
    
end


