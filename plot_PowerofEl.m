function plot_PowerofEl (time,satelite,channel,receiver)
% расчет мощности сигнала КА для зоны в произвольные моменты времени

% mode=0 - отдельная карта для каждого КА
% mode=1 - суммарная карта для всех КА
% mode=2 - отдельные и суммарная карта


sat = satelite(1);

lat = -90:0.1:90;
size_lat = length(lat);

long = zeros(1,size_lat)+sat.long;


size_long = length(long);

        orbit = sat.orbit;
       
        if (size(orbit,1)>1)    % если орбита задана в виде массива точек во времени (не ГСО)
            return
        end
        
        % угол места, расстояние и 
        [el,~,r,phi] = calc_geometry (lat,long,orbit,sat.angle2north,sat.angle2east,receiver.h);
        
        % расчет мощности в зоне
        p = zeros(size(lat)) - receiver.Pmin;          % КОСТЫЛЬ!!! надо перенести сюда расчет, учитываяющий тип сигнала и потребителя
        if orbit_checkWorkzone(sat,orbit)       % только если КА в рабочей зоне
            for i=1:size_lat
            	p(i) = calc_power(el(i),r(i),phi(i),channel,receiver);
            end
        end

Pmin = receiver.Pmin;
Pmax = receiver.Pmax;
       
figure(47);
clf
hold on
plot(el,p)
plot([0,90],[Pmin,Pmin], '--r')
plot([0,90],[Pmax,Pmax], '--r')
xlim([0 90]);
ylim([round(Pmin)-1,round(Pmax)+1]);
set(gca, 'xtick',0:5:90)
set(gca, 'ytick',round(Pmin)-1:1:round(Pmax)+1)
grid on;
        
%end



