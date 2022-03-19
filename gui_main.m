clc
clear

disp('1123')

transponder = dbTransponder('L1SBAS');       % сигнал (L1SBAS (Луч-5А,5Б,5В) или L1SDCM/L5KFD/L3KFD/L1KFD (новые КА) или L3Sigal (одна квадратура, повышенные требовани к уровню) или L1GLO/L2GLO/L3GLO)
user = dbUser('SARPs',transponder.signal);                       % пользователь (SARPs/Earth/КА на определенной высоте)
%user = dbUser('Resurs',transponder.signal);                       % Ресурс (высота орбиты 720 км)


% интересующее время
time = 0;
%time = 0:1/60:25;      % для Ресурса
%time = 0:6;      	% весь период


% выбор КА
%[file,path] = uigetfile('*.txt','Select satellite file','sat_geo.txt');
%filepath = sprintf('%s\\%s',path,file);
filepath = 'sat_geo.dat';
sat_file = fopen(filepath,'r');
%C = textscan(sat_file,'%s %f %f %f');
C = textscan(sat_file,'%s %f');
fclose(sat_file);
% выбор УССИ
[indx,tf] = listdlg('PromptString','Выберите КА','ListString',C{1},'CancelString','Exit');
if tf == 0
    return
end
ussinum = indx;

disp(ussinum)
disp(C{1}(ussinum))





% выбор времени


% выбор режимов расчета










%satelite = create_sat_array('Исполин1','Исполин2','Исполин3');
%satelite = create_sat_array('5V');                                     
satelite = create_sat_array('5B','5V','5A', '80');                                     % существующие КА "Луч-5Б" и "Луч-5В"
%satelite = create_sat_array('Электро-1','Электро-2','Электро-3'); 
%satelite = create_sat_array('5M1','5M2','5M3');     
%satelite = create_sat_array('80','140','95');
%satelite = create_sat_array('70','80','140','150');                        % КА ГСО с произвольно выбранными орбитальными позициями
%satelite = create_sat_array('АМ8','AM44','AM7','AM6','AM22','AM3','AM5');  % КА "Экспресс-АМ"
%satelite = create_sat_array('QZSSmax-6','Tundra');                         % КА ВКК
%satelite = create_sat_array('RNISS-1','RNISS-2','RNISS-3','RNISS-4','RNISS-5','RNISS-6');
%satelite = create_sat_array('KFD-VKK-1','KFD-VKK-2','KFD-VKK-3');                         % КА ВКК
%satelite = create_sat_array('GLONASS',1:24);
%satelite = create_sat_array('Efir');

%satelite = create_sat_array('QZSS-1','QZSS-2','QZSS-3','QZSS-4','QZSS-5','QZSS-6');
%satelite = create_sat_array('QZSS-1','QZSS-2','QZSS-3');
%satelite = create_sat_array('QZSS-1');
%transponder.angle2north = 0;

%user = create_sat_array('Resurs');
%user = orbit_set(time,user);

sat_color = create_str_array('blue','blue','blue','green','green');
user_color = create_str_array('red');


% разобраться с заданием орбиты по TLE-файлам или кеплеровским элементам орбиты
%earth_sphere_3d(satelite);
%orbit_readtle('TLE.txt',38977);      % чтение кеплеровских элементов орбиты из TLE-файла



%%------------------------------------------------------------------
% Варианты вывода на карту

% вывод на карту зон радиовидимости для выбранных КА по углу
%plotm_elevation(time,satelite,user,sat_color,[0,5],'newmap','plotfile');       

% вывод на карту орбит выбранных КА
%plotm_orbit(time,satelite,sat_color,'newmap','plotfile');

% вывод на карту кратности покрытия сигналами КА
%plotm_multi(time,satelite,user,5,sat_color);

% вывод на карту доступности сигналов КА
%plotm_availability(satelite,user,1);

% расчет энергетики на линии Космос-Земля
%plotm_power(time,satelite,transponder,user,1);

% расчет энергетики на линии Космос-Земля (вывод зоны в виде контура)
%plotm_power_line(time,satelite,transponder,user,1);

% вывод на карту углов возвышения на КА
%plotm_elevation_zone(time,satelite,user)

% вывод на карту зоны работы земной станции 
%city = create_city_array('Москва','Красноярск','Восточный');
%city = create_city_array('Москва');
%plotm_nles_zone(city,1100,5)

% вывод на карту углов от оси антенны КА
%plotm_satangles(time,satelite,user,sat_color,'newmap','plotfile');


% вывод на карту зон радиовидимости для выбранных КА по углу
%gnss = create_sat_array('KFD-VKK-1','KFD-VKK-2','KFD-VKK-3');
%gnss = create_sat_array('GLO');
%plotm_gnssvisibility(time,satelite,gnss,user,sat_color,'newmap','plotfile');

% вывод на карту орбит выбранных КА
%plotm_satzones(time,satelite,sat_color,'newmap','plotfile');
%plotm_satzones(time,satelite,user);

%%------------------------------------------------------------------
% Варианты вывода на график

% угол возвышения КА в зависимости от долготы потребителя
%plot_ElofLong(0,satelite,user)

% мощность сигнала в зависимости от угла возвышения КА
%plot_PowerofEl(time,satelite,transponder,user)

% мощность сигнала в зависимости от широты потребителя
%plot_PowerofLat(time,satelite,transponder,user)


%%------------------------------------------------------------------
% обновить, пока не работает

% вывод изменения азимута, угла места и расстояния для точки
%plot_time_aer(orbit_VKK1,point);

% расчет высоты и требуемой ширины ДН антенны КА
%plot_time_h(orbit_VKK1);

% зависимость угла от оси КА на точку от времени
%plot_time_phi(orbit_VKK1,'Москва','Байконур','Красноярск');

% расчет доступности (процент времени, когда угол места на КА больше нуля)
%calc_availability(time,satelite,user);

