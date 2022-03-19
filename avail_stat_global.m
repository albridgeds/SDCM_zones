function avail = avail_stat_global(lat,long,zone,limit)



pi=3.1415926535;
Llong = 20004.274/180;                      % длина дуги в 1 градус по меридиану (км)


size_lat = size(zone,1);
size_long = size(zone,2);


count0 = 0;
count1 = 0;


% просмотр всех точек зоны, для которых во внешней функции проведен расчет многократности покрытия (вся Земля с шагом 1 градус)
for i=1:size_lat
    
    Llat = 111.3*cos(lat(i,1)*pi/180);      % длина дуги в 1 градус по параллели на заданной широте (км)
    S1 = Llong*Llat;                      % элемент площади на текущей широте
        
    for j = 1:size_long
        if (zone(i,j)>=limit)
            count1 = count1+S1;
        else
            count0 = count0+S1;
        end
    end
end

avail = count1/(count0+count1)*100;

% вывод статистики в текстовом виде
fprintf('\nGlobal availability zone: %.1f%%\n',avail);


end

