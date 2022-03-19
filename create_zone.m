function [lat,long] = create_zone (name)
%CREATE_ZONE Summary of this function goes here
%   Detailed explanation goes here

switch name
    case 'earth'
        lat_min = -90;
        lat_max = 90;
        long_min = -180;
        long_max = 180;
        
        step_lat = 5;
        step_long = 5;

        size_lat = (lat_max-lat_min)/step_lat+1;        % +1 чтобы не было пустого места на краю графика
        size_long = (long_max-long_min)/step_long+1;
        size = size_lat*size_long;

        lat = zeros(1,size);
        long = zeros(1,size);

        lat1 = lat_min:step_lat:lat_max;
        long1 = long_min:step_long:long_max;

        for i=1:size_lat
            for j=1:size_long
                lat((i-1)*size_long+j)=lat1(i);
                long((i-1)*size_long+j)=long1(j);
            end
        end        
        
        
    case 'russia'
        russia_zone = load('russia_zone3.dat');          % массив точек с шагом 1 градус по широте и долготе, закрывающий всю территорию РФ
        long = russia_zone(:,1);
        lat = russia_zone(:,2);

end

end

