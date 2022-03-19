function orbit = sp3togeodetic (orbit0,t_start,long_shift)
%SP3TOGEODETIC Summary of this function goes here
%   Detailed explanation goes here


[time0,time_step,time_period] = time_init();
size = time_period/time_step;       % количество 


t1 = round(mod(t_start-time0,time_period)/time_step)+1;     % индекс времени начала
t2 = t1+size;                                               % индекс времени окончания

x = orbit0(t1:t2,1)*1000;
y = orbit0(t1:t2,2)*1000;
z = orbit0(t1:t2,3)*1000;


spheroid = referenceEllipsoid('WGS 84');
[lat,long,h] = ecef2geodetic(spheroid,x,y,z);

long = long + long_shift;

orbit = [lat,long,h];


end

