function [zone_e,zone_a,zone_r,zone_phi] = calc_geometry (lat,long,orbit,angle2north,angle2east,h)
%ZONE_ELEVATION Summary of this function goes here
%   Detailed explanation goes here

satlat = orbit(:,1);
satlong = orbit(:,2);
sath = orbit(:,3);


% расчет азимута, возвышения и расстояния для каждой точки зоны
%h = 0;
%h = 20000000;   % 20тыс. км - высота орбиты ГЛОНАСС
%h = 720000;     % 720км - высота орбиты Ресурс-ПМ
spheroid = referenceEllipsoid('WGS 84');
[zone_a,zone_e,zone_r] = geodetic2aer(satlat,satlong,sath,lat,long,h,spheroid);



latmax = size(zone_a,1);
longmax = size(zone_a,2);

% если антенна смотрит в подспутниковую точку, работают быстрые встроенные формулы
if (angle2north==0 && angle2east==0)
    
    % расчет угла относительно оси КА для каждой точки зоны
    [~,zone_phi,~] = geodetic2aer(lat,long,h,satlat,satlong,sath,spheroid);
    zone_phi = 90 + zone_phi;
    
    % убираем положительные углы с другой стороны Земли
    for i=1:latmax
        for j=1:longmax
            if zone_e(i,j)<0
                zone_phi(i,j)=100;
            end
        end
    end

% если антенна наклонена, приходится вычислять медленными собственными формулами
else
  
    pi = 3.1415926535;
    Rz = 6378136;      % радиус Земли (м)

    angle2north = angle2north*pi/180;
    angle2east = angle2east*pi/180;

    zone_phi = zeros(latmax,longmax);

    for i=1:latmax
        for j=1:longmax

            if zone_e(i,j)<0
                zone_phi(i,j)=100;
            else
                dLong = (long(i,j)-satlong)*pi/180;
                dLat = (lat(i,j)-satlat)*pi/180;
                Rgeo = Rz + sath;

                % расстояние до спутника в азимутальной плоскости
                R1 = (Rz+h)*cos(dLat);
                r_az = sqrt(R1*R1 + Rgeo*Rgeo - 2*R1*Rgeo*cos(dLong));
                Az = asin(Rgeo/r_az*sin(dLong));        % это ни фига не азимут на спутник (см. картинки), но именно поэтому работает!!!

                % угол места на спутник
                El = zone_e(i,j)*pi/180;

                % полный угол от оси спутника на точку
                Teta0 = asin((Rz+h)/Rgeo*cos(El));

                % угол от оси спутника на точку по азимуту
                Teta_az0 = abs(Az-dLong);
                Teta_az = abs(Az-dLong-angle2east);

                % угол от оси спутника на точку по углу места
                Teta0_um = atan(sqrt(tan(Teta0)*tan(Teta0) - tan(Teta_az0)*tan(Teta_az0)));

                % угол от оси антенны на точку по углу места
                if (dLat>0)
                    Teta_um = abs(Teta0_um - angle2north);
                else
                    Teta_um = abs(Teta0_um + angle2north);
                end

                % полный угол от оси антенны на точку
                Teta = atan(sqrt(tan(Teta_um)*tan(Teta_um) + tan(Teta_az)*tan(Teta_az)));
                zone_phi(i,j) = Teta*180/pi;

            end
        end
    end
end


