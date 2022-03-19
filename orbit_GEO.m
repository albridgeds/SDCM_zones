function orbit = orbit_GEO(long)
%BLH for GEO satelite

Rgeo = 42164200;
Re = 6378136;

orbit = [0,long,Rgeo-Re];       % [lat,long,h] format
if (long<-180) || (long>180)
    orbit = 0;
end

end

