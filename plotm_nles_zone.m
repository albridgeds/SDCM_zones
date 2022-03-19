function plotm_nles_zone (city,sath,el)
% расчет мощности сигнала КА для зоны в произвольные моменты времени


[lat,long] = zone_earth();

size_lat = size(lat,1);
size_long = size(lat,2);

% по очереди перебираем спутники
for c=1:length(city)

    spheroid = referenceEllipsoid('WGS 84');
    [~,zone_e,~] = geodetic2aer(lat,long,sath*1000,city(c).lat,city(c).long,0,spheroid);

    contourm(lat,long,zone_e,[el el],'LineColor','g','LineWidth',2);
    plotm(city(c).lat,city(c).long,'or')

end

end




