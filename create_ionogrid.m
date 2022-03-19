%function [ionogrid_lat,ionogrid_long] = create_ionogrid(bands)
function igp = create_ionogrid(bands)


ionogrid_lat = [];
ionogrid_long = [];

for b=1:length(bands)
    
    band = bands(b);

    if (band < 0 || band > 10)
        disp('create_ionogrid ERROR: band should be 0...10 and it is' + band)
        continue;
        
    elseif band <= 8
        startlong = -180 + 40*band;
        
        %lat1 = -55:5:55;
        lat1 = 0:5:55;                  % берем только северное полушарие
        long1 = startlong:5:startlong+35;
        [ionogrid_lat,ionogrid_long] = add_tmp_grid(ionogrid_lat,ionogrid_long,lat1,long1);
        
        %lat2 = [-75,-65,65,75];
        lat2 = [65,75];                 % берем только северное полушарие
        long2 = startlong:10:startlong+30;
        [ionogrid_lat,ionogrid_long] = add_tmp_grid(ionogrid_lat,ionogrid_long,lat2,long2);
        
        if band <= 7
            add_long = [-180,-140,-90,-50,0,40,90,130];
            add_lat = [85,-85,85,-85,85,-85,85,-85];
            ionogrid_lat = [ionogrid_lat; add_lat(band+1)];
            ionogrid_long = [ionogrid_long; add_long(band+1)];
        end
        
    elseif band == 9
        
        tmp_grid_lat = [];
        tmp_grid_long = [];
        
        lat1 = 60;
        long1 = -180:5:175;
        [tmp_grid_lat,tmp_grid_long] = add_tmp_grid(tmp_grid_lat,tmp_grid_long,lat1,long1);
        
        lat2 = [65,70,75];
        long2 = -180:10:170;
        [tmp_grid_lat,tmp_grid_long] = add_tmp_grid(tmp_grid_lat,tmp_grid_long,lat2,long2);
        
        lat3 = 85;
        long3 = -180:30:150;
        [tmp_grid_lat,tmp_grid_long] = add_tmp_grid(tmp_grid_lat,tmp_grid_long,lat3,long3);
        
        [ionogrid_lat,ionogrid_long] = add_new_points(ionogrid_lat,ionogrid_long,tmp_grid_lat,tmp_grid_long);
        
    elseif band == 10

        tmp_grid_lat = [];
        tmp_grid_long = [];
        
        lat1 = -60;
        long1 = -180:5:175;
        [tmp_grid_lat,tmp_grid_long] = add_tmp_grid(tmp_grid_lat,tmp_grid_long,lat1,long1);
        
        lat2 = [-65,-70,-75];
        long2 = -180:10:170;
        [tmp_grid_lat,tmp_grid_long] = add_tmp_grid(tmp_grid_lat,tmp_grid_long,lat2,long2);
        
        lat3 = -85;
        long3 = -170:30:160;
        [tmp_grid_lat,tmp_grid_long] = add_tmp_grid(tmp_grid_lat,tmp_grid_long,lat3,long3);
        
        [ionogrid_lat,ionogrid_long] = add_new_points(ionogrid_lat,ionogrid_long,tmp_grid_lat,tmp_grid_long);
        
    end
    
end

igp = [ionogrid_lat  ionogrid_long];

end


function [grid_lat,grid_long] = add_tmp_grid(grid_lat,grid_long,lat,long)
    N = length(lat)*length(long);
    tmp_grid_lat = zeros(N,1);
    tmp_grid_long = zeros(N,1);
	for i = 1:length(lat)
        for j = 1:length(long)
        	n = (i-1)*length(long) + j;
        	tmp_grid_lat(n) = lat(i);
        	tmp_grid_long(n) = long(j);
        end
	end
    grid_lat = [grid_lat; tmp_grid_lat];
    grid_long = [grid_long; tmp_grid_long];
end


function [grid_lat,grid_long] = add_new_points(grid_lat,grid_long,tmp_lat,tmp_long)
	for i = 1:length(tmp_lat)
        id_lat = find(grid_lat==tmp_lat(i));
        id_long = find(grid_long==tmp_long(i));
        if ~any(ismember(id_lat,id_long))
            grid_lat = [grid_lat; tmp_lat(i)];
            grid_long = [grid_long; tmp_long(i)];
        end
	end
end





