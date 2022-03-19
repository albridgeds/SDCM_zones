function [lat,long] = dbCity (cityname)
%DATABASECITY Summary of this function goes here
%   Detailed explanation goes here


if strcmp(cityname,'Moscow') || strcmp(cityname,'Москва')
    lat = 55.75;
    long = 37.35;
elseif strcmp(cityname,'Khabarovsk') || strcmp(cityname,'Хабаровск')
    lat = 48.48;
    long = 135.07;
elseif strcmp(cityname,'Krasnoyarsk') || strcmp(cityname,'Красноярск')
    lat = 56.02;
    long = 92.87;
elseif strcmp(cityname,'Irkutsk') || strcmp(cityname,'Иркутск')
    lat = 52.28;
    long = 104.13;
elseif strcmp(cityname,'Vladivostok') || strcmp(cityname,'Владивосток')
    lat = 43+07/60;
    long = 131+54/60;
elseif strcmp(cityname,'Magadan') || strcmp(cityname,'Магадан')
    lat = 59+34/60;
    long = 150+48/60;
elseif strcmp(cityname,'Petropavlovsk') || strcmp(cityname,'Петропавловск')
    lat = 53+01/60;
    long = 158+39/60;
elseif strcmp(cityname,'Baikonur') || strcmp(cityname,'Байконур')
    lat = 45+57/60;
    long = 63+18/60;
elseif strcmp(cityname,'Vostochniy') || strcmp(cityname,'Восточный')
    lat = 51+53/60;
    long = 128+20/60;
elseif strcmp(cityname,'Managua') || strcmp(cityname,'Nicaragua') || strcmp(cityname,'Манагуа') || strcmp(cityname,'Никарагуа')
    lat = 12+9/60;
    long = -86+16/60;
elseif strcmp(cityname,'Sabetta') || strcmp(cityname,'Сабетта')
    lat = 72;
    long = 74;
    
elseif strcmp(cityname,'Kaliningrad') || strcmp(cityname,'Калининград')
    lat = 54+43/60;
    long = 20+30/60;
elseif strcmp(cityname,'Murmansk') || strcmp(cityname,'Мурманск')
    lat = 68+56/60;
    long = 33+05/60;
elseif strcmp(cityname,'Sevastopol') || strcmp(cityname,'Севастополь')
    lat = 44+36/60;
    long = 33+32/60;
elseif strcmp(cityname,'Rostov') || strcmp(cityname,'Ростов') || strcmp(cityname,'Ростов-на-Дону')%
    lat = 47+14/60;
    long = 39+42/60;
elseif strcmp(cityname,'Derbent') || strcmp(cityname,'Дербент')
    lat = 42+04/60;
    long = 48+17/60;
elseif strcmp(cityname,'Samara') || strcmp(cityname,'Самара')
    lat = 53+11/60;
    long = 50+07/60;
    
elseif strcmp(cityname,'Чернышевский')
    lat = 63.02;
    long = 112.47;
elseif strcmp(cityname,'Провидения')
    lat = 64.42;
    long = -173.21;
elseif strcmp(cityname,'Тикси')
    lat = 71.69;
    long = 128.86;
elseif strcmp(cityname,'Южно-Сахалинск')
    lat = 46.95;
    long = 142.73;
elseif strcmp(cityname,'Тында')
    lat = 55.15;
    long = 124.72;
elseif strcmp(cityname,'Певек')
    lat = 69.70;
    long = 170.32;
elseif strcmp(cityname,'Чокурдах')
    lat = 70.61;
    long = 147.89;
    
elseif strcmp(cityname,'Архангельск')
    lat = 64.53;
    long = 40.51;
elseif strcmp(cityname,'Диксон')
    lat = 73.20;
    long = 80.30;
elseif strcmp(cityname,'Баранова')
    lat = 78.48;
    long = 103.75;
elseif strcmp(cityname,'Оренбург')
    lat = 51.76;
    long = 55.09;
elseif strcmp(cityname,'Кызыл-Озек')
    lat = 51.89;
    long = 85.99;
elseif strcmp(cityname,'Кармакулы')
    lat = 72.37;
    long = 52.71;
elseif strcmp(cityname,'Ханты-Мансийск')
    lat = 61;
    long = 69;
elseif strcmp(cityname,'Благовещенск')
    lat = 50.28;
    long = 127.53;
    
elseif strcmp(cityname,'Кызыл')
    lat = 51+42/60;
    long = 94+22/60;
elseif strcmp(cityname,'Чита')
    lat = 52.03;
    long = 113.49;
elseif strcmp(cityname,'Сыктывкар')
    lat = 61.66;
    long = 50.83;
elseif strcmp(cityname,'Салехард')
    lat = 66.53;
    long = 66.61;
elseif strcmp(cityname,'Колпашево')
    lat = 58.31;
    long = 82.9;
   
elseif strcmp(cityname,'Якутск')
    lat = 62.02;
    long = 129.73;
elseif strcmp(cityname,'Усть-Нера')
    lat = 64+34/60;
    long = 143+14/60;
elseif strcmp(cityname,'Ленск')
    lat = 60.73;
    long = 114.93;
elseif strcmp(cityname,'Оленек')
    lat = 68.5;
    long = 112.44;
elseif strcmp(cityname,'Аян')
    lat = 56.46;
    long = 138.17;
elseif strcmp(cityname,'Тиличики')
    lat = 60.42;
    long = 166.05;
elseif strcmp(cityname,'Анадырь')
    lat = 64.73;
    long = 177.51;
elseif strcmp(cityname,'Северо-Курильск')
    lat = 50.67;
    long = 156.12;
elseif strcmp(cityname,'Кяхта')
    lat = 50.36;
    long = 106.45;
elseif strcmp(cityname,'Вал')
    lat = 52.34;
    long = 143.06;
elseif strcmp(cityname,'Китовый')
    lat = 45.25;
    long = 147.89;
    
elseif strcmp(cityname,'Туруханск')
    lat = 65.79;
    long = 87.96;
elseif strcmp(cityname,'Хатанга')
    lat = 71.97;
    long = 102.46;
elseif strcmp(cityname,'Никольское')
    lat = 55.19;
    long = 165.99;
elseif strcmp(cityname,'Уэлен')
    lat = 66.17;
    long = -169.8;
elseif strcmp(cityname,'Астрахань')
    lat = 46.34;
    long = 48.03;
elseif strcmp(cityname,'Арти')  % ?????????????????????????????
    lat = 56.42;
    long = 58.53;
elseif strcmp(cityname,'Братск')
    lat = 56+7/60;
    long = 101+36/60;
elseif strcmp(cityname,'Кызылорда')
    lat = 44.83;
    long = 65.5;
elseif strcmp(cityname,'Пусан')
    lat = 35.17;
    long = 129.09;
elseif strcmp(cityname,'Урумчи')
    lat = 43.78;
    long = 87.58;
elseif strcmp(cityname,'Чанчунь')
    lat = 43.87;
    long = 125.31;
elseif strcmp(cityname,'Цзяюйгуань')
    lat = 39+49/60;
    long = 98+18/60;
    
elseif strcmp(cityname,'Судак')
    lat = 44.85;
    long = 34.97;
elseif strcmp(cityname,'Менделеево')
    lat = 56.03;
    long = 37.22;
elseif strcmp(cityname,'Астана')
    lat = 51.12;
    long = 71.43;
elseif strcmp(cityname,'Светлое')
    lat = 60.67;
    long = 28.87;
elseif strcmp(cityname,'Ереван')
    lat = 40.17;
    long = 44.51;
elseif strcmp(cityname,'Минск')
    lat = 53.9;
    long = 27.55;
    
elseif strcmp(cityname,'Беллинсгаузен')
    lat = -62.18;
    long = -58.5;
elseif strcmp(cityname,'Прогресс')
    lat = -69.37;
    long = 79.38;
elseif strcmp(cityname,'Новолазаревская')
    lat = -70.77;
    long = 11.38;

    
    
else sprintf('Error: unknown city name - %s',cityname)


end

