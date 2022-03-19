function orbit = orbit_VKK1(sat,num)
%ORBIT_VKK Summary of this function goes here
%   Detailed explanation goes here


long1 = 60;
long2 = 120;

name = strcat(sat,'.txt');
orbit = load(name);

N = 3;
orbit_period = 86160;                               % период в секундах для номинальной орбиты по ИД
sat_time_step = orbit_period/N/3600;                % насколько разнесены спутники в часах

if strncmp(sat,'QZSS',4)
    sat_time_shift = 1.2;                           % сдвиг времени для удобства, чтобы первый КА был в апогее ровно в 12 часов
    sat_time_shift2 = sat_time_shift + sat_time_step/2;           % сдвиг времени для удобства, чтобы четвертый КА входил в рабочий участок ровно в 12 часов
    sat_long0 = 92;                                 % долгота восходящего узла в sp3 Фурсова
elseif strncmp(sat,'Tundra',6)
    sat_time_shift = 3.2;                           % сдвиг времени для удобства, чтобы первый КА был в апогее ровно в 12 часов
    sat_time_shift2 = sat_time_shift + sat_time_step/2;           % сдвиг времени для удобства, чтобы четвертый КА входил в рабочий участок ровно в 12 часов
    sat_long0 = 63;                                 % долгота восходящего узла в sp3 Фурсова
else
    sat_time_shift = 0;
    sat_time_shift2 = 0;
    sat_long0 = 0;
end


switch num
    case 1
        orbit = sp3togeodetic (orbit,sat_time_shift,long1-sat_long0);                      % 60 градусов №1
        
    case 2
        orbit = sp3togeodetic (orbit,sat_time_shift+sat_time_step,long1-sat_long0);        % 60 градусов №2
        %sat.nles_long = long1;
    case 3
        orbit = sp3togeodetic (orbit,sat_time_shift+2*sat_time_step,long1-sat_long0);      % 60 градусов №3
        %sat.nles_long = long1;
    case 4
        orbit = sp3togeodetic (orbit,sat_time_shift2,long2-sat_long0);                     % 120 градусов №1
        %sat.nles_long = long2;
    case 5
        orbit = sp3togeodetic (orbit,sat_time_shift2+sat_time_step,long2-sat_long0);       % 120 градусов №2
        %sat.nles_long = long2;
    case 6
        orbit = sp3togeodetic (orbit,sat_time_shift2+2*sat_time_step,long2-sat_long0);     % 120 градусов №3
        %sat.nles_long = long2;
end

%sat.nles_lat = 45;

time = 0:150:12*3600;                               % время в sp3 Фурсова
orbit = [orbit,time'];

