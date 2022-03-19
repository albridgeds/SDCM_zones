function [zone_e] = calc_elevation (lat,long,orbit,user_h)
% быстрый расчет угла места
% просто убрано все лишнее из функции zone_geometry


satlat = orbit(:,1);
satlong = orbit(:,2);
sath = orbit(:,3);

% расчет азимута, возвышения и расстояния для каждой точки зоны
%h = 0;
spheroid = referenceEllipsoid('WGS 84');
[~,zone_e,~] = geodetic2aer(satlat,satlong,sath,lat,long,user_h,spheroid);




