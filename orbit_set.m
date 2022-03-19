function satelite = orbit_set (time,satelite)
%SET_ORBIT Summary of this function goes here
%   Detailed explanation goes here


satlen = length(satelite);
%timelen = length(time);

%time1 = time(1)*3600;
%time2 = time(end)*3600;
%dt = (time(2)-time(1))*3600;
time = time*3600;   % переводим часы в секунды


% перебираем все спутники
for i=1:satlen
    
    % файл с прогнозом орбиты для очередного спутника
    name = strcat('orbit_',satelite(i).name,'.txt');
    file = load(name);
    fileTime = file(:,1);
    
    time_start = fileTime(1);
    time_period = fileTime(end);
    time_step = fileTime(2) - fileTime(1);
    
    % определяем строки координат из файла, к которым нужно обращаться 
    index = round(mod(time-time_start,time_period)/time_step)+1;
    
    
    %orbit = file(index,2:4)*1000;
    satelite(i).orbit = file(index,2:4);
    
    %spheroid = referenceEllipsoid('WGS 84');
    %[lat,long,h] = ecef2geodetic(spheroid,file(index,2)*1000,file(index,3)*1000,file(index,4)*1000);
    %orbit = [lat,long,h];
    %satelite(i).orbit = orbit;

    
    %for j=1:length(time)
    %   printf('',time) 
    %end
    
   
end




