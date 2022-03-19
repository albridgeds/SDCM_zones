function [lat_ipp,long_ipp] = ipp_calc(lat_r,long_r,orbit)


Re = 6378.137;
h = 350;

deg2rad = pi/180;
rad2deg = 180/pi;


[el,az,~,~] = calc_geometry (lat_r,long_r,orbit,0,0,0);

lat_ipp = zeros(1,length(el)) + 1000;
long_ipp = zeros(1,length(el)) + 1000;

beta = asin(Re/(Re+h)*cos(el*deg2rad))*rad2deg;
alpha = (90-el-beta)*deg2rad;

for t=1:length(el)
    if (el(t)>5)
        lat_ipp(t) = asin( sin(alpha(t))*cos(az(t)*deg2rad)*cos(lat_r*deg2rad) + cos(alpha(t))*sin(lat_r*deg2rad) );
        long_ipp(t) = long_r*deg2rad + asin( sin(alpha(t))*sin(az(t)*deg2rad)/cos(lat_ipp(t)) );
    end
end

lat_ipp = lat_ipp*rad2deg;
long_ipp = long_ipp*rad2deg;

end

