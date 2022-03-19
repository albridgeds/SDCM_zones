function [lat,long] = zone_earth()
%ZONE_EARTH Summary of this function goes here
%   Detailed explanation goes here




% создание массива широты и долготы
lat_min = -90;
lat_max = 90;
long_min = -180;
long_max = 180;

step_lat = 1;
step_long = 1;

size_lat = (lat_max-lat_min)/step_lat+1;        % +1 чтобы не было пустого места на краю графика
size_long = (long_max-long_min)/step_long+1;

lat = zeros(size_lat,size_long);
long = zeros(size_lat,size_long);


lat1 = lat_min:step_lat:lat_max;
long1 = long_min:step_long:long_max;



for i=1:size_lat
    for j=1:size_long
        lat(i,j)=lat1(i);
        long(i,j)=long1(j);
    end
end



end

