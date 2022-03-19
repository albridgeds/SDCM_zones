function avail = avail_stat_russia(lat,long,zone,limit)


pi=3.1415926535;
Llong = 20004.274/180;                      % длина дуги в 1 градус по меридиану (км)

russia_zone = load('russia_zone.dat');          % массив точек с шагом 1 градус по широте и долготе, закрывающий всю территорию РФ
long_rus = russia_zone(:,1);
lat_rus = russia_zone(:,2);
len = length(lat_rus);

count0 = 0;
count1 = 0;


% просмотр всех точек в пределах России (это быстрее, чем искать Россию в мире)
for i=1:len
    f1 = find(lat==lat_rus(i));         % индексы точек рабочей зоны, совпадающие с текущей точкой на территории РФ по широте 
    f2 = find(long==long_rus(i));       % индексы точек рабочей зоны, совпадающие с текущей точкой на территории РФ по долготе
    f = intersect(f1,f2);               % индекс точки рабочей зоны КА, совпадающей с текущей точкой на территории РФ
    if isempty(f)
        continue
    end

    Llat = 111.3*cos(lat(i)*pi/180);      % длина дуги в 1 градус по параллели на заданной широте (км)
    S1 = Llong*Llat;                      % элемент площади на текущей широте и долготе

    if (zone(f)>=limit)
        count1 = count1+S1;
    else
        count0 = count0+S1;
    end
end

avail = count1/(count0+count1)*100;


% вывод статистики в текстовом виде
fprintf('\nAvailability zone for Russia: %.1f%%\n',avail);


end

