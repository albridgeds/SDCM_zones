function sat = dbSat (satname)
% выдача координат спутника по его имени или значению долготы (только для ГСО)
% для ВКК выдается массив координат



% если входное значение - число, задающее долготу спутника (только для ГСО)
num = str2double(satname{1});
if (~isempty(num))              % если удалось преобразовать в число
    if (num>=-180 && num<=180)  % если результат преобразования в требуемых границах
        %orbname = ['GEO',abs(num)]
        %orbname = strcat('GEO',abs(num))
        orbname = strcat('GEO',satname);
        if (num<0)
            orbname = [orbname,'W'];
        elseif (num>0)
            orbname = [orbname,'E'];
        end
        sat = SATELITE(orbname{1},'GEO',num,1);
        sat.orbit = orbit_GEO(num);
        return;
    end
end

sat.name = 'none';



% КА на ГСО
switch satname{1}
    
    % ИСС им. Решетнева
    case {'Luch-5A','Луч-5А','5A','5А'}
        sat = SATELITE('Luch-5A','GEO',167,1);
        sat.angle2north = 7;
    case {'Luch-5B','Луч-5Б','5B','5Б'}
        sat = SATELITE('Luch-5B','GEO',-16,1);
        sat.angle2north = 7;
    case {'Luch-5V','Луч-5В','5V','5В'}
        sat = SATELITE('Luch-5V','GEO',95,1);
        sat.angle2north = 7;
    case {'Luch-160','Луч-160'}
        sat = SATELITE('Luch-5A','GEO',-160,1);
        sat.angle2north = 7;
        
    case {'Luch-5M1','Луч-5М1','5M1','5М1'}
        sat = SATELITE('Luch-5M1','GEO',167,3);
        sat.angle2north = 7;
    case {'Luch-5M2','Луч-5М2','5M2','5М2'}
        sat = SATELITE('Luch-5M2','GEO',-16,3);
        sat.angle2north = 7;
    case {'Luch-5M3','Луч-5М3','5M3','5М3'}
        sat = SATELITE('Luch-5M3','GEO',95,3);
        sat.angle2north = 7;
        
    case {'Enisei','Enisey','Енисей'}
        sat = SATELITE('Enisei','GEO',95,4);
        
 
    % НПО им. Лавочкина
    case {'Electro-L1','Электро-Л1','Electro-1','Электро-1'}
        sat = SATELITE('Electro','GEO',-14.5,1);
    case {'Electro-L2','Электро-Л2','Electro-2','Электро-2'}
        sat = SATELITE('Electro','GEO',76,1);
    case {'Electro-L3','Электро-Л3','Electro-3','Электро-3'}
        sat = SATELITE('Electro','GEO',165,1);
        
	% ГПКС
    case {'Express-AM3','Экспресс-АМ3','AM3','АМ3'}
        sat = SATELITE('Express-AM3','GEO',103,1);
    case {'Express-AM5','Экспресс-АМ5','AM5','АМ5'}
        sat = SATELITE('Express-AM5','GEO',140,1);
    case {'Express-AM6','Экспресс-АМ6','AM6','АМ6'}
        sat = SATELITE('Express-AM6','GEO',53,1);
    case {'Express-AM8','Экспресс-АМ8','AM8','АМ8'}
        sat = SATELITE('Express-AM8','GEO',-14,1);
    case {'Express-AM7','Экспресс-АМ7','AM7','АМ7'}
        sat = SATELITE('Express-AM7','GEO',40,1);
    case {'Express-AM22','Экспресс-АМ22','AM22','АМ22'}
        sat = SATELITE('Express-AM22','GEO',80,1);
    case {'Express-AM33','Экспресс-АМ33','AM33','АМ33'}
        sat = SATELITE('Express-AM33','GEO',96.5,1);
    case {'Express-AM44','Экспресс-АМ44','AM44','АМ44'}
        sat = SATELITE('Express-AM44','GEO',-11,1);
    case {'Express-80','Экспресс-80'}
        sat = SATELITE('Express-80','GEO',80,1);
    case {'Express-103','Экспресс-103'}
        sat = SATELITE('Express-103','GEO',103,1);
    case {'Express-AMU5','Экспресс-АМУ5','AMU5','АМУ5'}
        sat = SATELITE('Express-AMU5','GEO',140,1);
    case {'Express-AMU6','Экспресс-АМУ6','AMU6','АМУ6'}
        sat = SATELITE('Express-AMU6','GEO',53,1);

        
    % EGNOS
    case {'Inmarsat-3F2','3F2'}
        sat = SATELITE('Inmarsat-3F2','GEO',-15.5,1);
    case 'SES-5'
        sat = SATELITE('SES-5','GEO',5,1);
    case 'Astra-5B'
        sat = SATELITE('Astra-5B','GEO',31.5,1);
       
    
    % Минобороны
    case {'Sphere-S1','Сфера-С1','Sphere1','Сфера1'}
        sat = SATELITE('Sphere-S','GEO',12,1);
    case {'Sphere-S2','Сфера-С2','Sphere2','Сфера2'}
        sat = SATELITE('Sphere-S','GEO',70,1);
    case {'Sphere-S3','Сфера-С3','Sphere3','Сфера3'}
        sat = SATELITE('Sphere-S','GEO',85,1);
        
    case {'Gerakl-KV1','Геракл-КВ1','Gerakl1','Геракл1','Ispolin1','Исполин1'}
        sat = SATELITE('Ispolin','GEO',-15,1);
        sat.angle2north = 7;
    case {'Gerakl-KV2','Геракл-КВ2','Gerakl2','Геракл2','Ispolin2','Исполин2'}
        sat = SATELITE('Ispolin','GEO',80,1);
        sat.angle2north = 7;
    case {'Gerakl-KV3','Геракл-КВ3','Gerakl3','Геракл3','Ispolin3','Исполин3'}
        sat = SATELITE('Ispolin','GEO',-168,1);
        sat.angle2north = 7;
        
    case {'Blagovest1','Благовест1'}
        sat = SATELITE('Blagovest','GEO',35,1);
    case {'Blagovest2','Благовест2'}
        sat = SATELITE('Blagovest','GEO',45,1);
    case {'Blagovest3','Благовест3'}
        sat = SATELITE('Blagovest','GEO',70,1);
    case {'Blagovest4','Благовест4'}
        sat = SATELITE('Blagovest','GEO',85,1);
    case {'Blagovest5','Благовест5'}
        sat = SATELITE('Blagovest','GEO',128,1);
        
end

   

% КА ВКК
if (strncmp(satname,'QZSSmax',5))
    sat = SATELITE('QZSSmax','VKK',0,1);
elseif (strncmp(satname,'QZSSmin',5))
    sat = SATELITE('QZSSmin','VKK',0,1);
elseif (strncmp(satname,'QZSS',4))
    sat = SATELITE('QZSS','VKK',0,1);
elseif (strncmp(satname,'Tundra1',7))
    sat = SATELITE('Tundramax','VKK',0,1);
elseif (strncmp(satname,'Tundramin',7))
    sat = SATELITE('Tundramin','VKK',0,1);
elseif (strncmp(satname,'Tundra',6))
    sat = SATELITE('Tundra','VKK',0,1);


elseif (strncmp(satname,'Resurs',6))
    sat = SATELITE('Resurs','Resurs',0,1);
    sat.a   = 6378.1363+720;
    sat.ecc = 0;
    sat.inc = degtorad(98.25);
    sat.O   = degtorad(130);        %130,250,10
    sat.w   = degtorad(270);        
    sat.nuo = degtorad(0);
    num = dBSat_VKKnum(satname{1},sat.name);
    if num==2
        sat.O = 250;
    elseif num==3
        sat.O = 10;
    end


elseif (strncmp(satname,'RNISS',5))
    sat = SATELITE('RNISS','RNISS',0,1);
    sat.a   = 42162.800;
    sat.ecc = 0.3;
    sat.inc = degtorad(64.8);
    sat.O   = degtorad(140);        % 140,20,260,   140,20,260
    sat.w   = degtorad(269);
    sat.nuo = degtorad(0);          % 0,120,240,    60,180,300
    sat.period = 24*3600;
    num = dBSat_VKKnum(satname{1},sat.name);
    if num==2
        sat.O = degtorad(20);
        sat.nuo = degtorad(120);
    elseif num==3
        sat.O = degtorad(260);
        sat.nuo = degtorad(240);
    elseif num==4
        sat.O = degtorad(140);
        sat.nuo = degtorad(60);
    elseif num==5
        sat.O = degtorad(20);
        sat.nuo = degtorad(180);
    elseif num==6
        sat.O = degtorad(260);
        sat.nuo = degtorad(300);
    end

    
elseif (strncmp(satname,'GMISS',5))
    sat = SATELITE('GMISS','GMISS',0,1);
    sat.a   = 870;
    sat.ecc = 0;
    sat.inc = degtorad(86.4);
    sat.O   = degtorad(140);        % 140,20,260,   140,20,260
    sat.w   = degtorad(269);        
    sat.nuo = degtorad(0);          % 0,120,240,    60,180,300
    sat.period = 24*3600;
    num = dBSat_VKKnum(satname{1},sat.name);
    if num==2
        sat.O = degtorad(20);
        sat.nuo = degtorad(120);
    elseif num==3
        sat.O = degtorad(260);
        sat.nuo = degtorad(240);
    elseif num==4
        sat.O = degtorad(140);
        sat.nuo = degtorad(60);
    elseif num==5
        sat.O = degtorad(20);
        sat.nuo = degtorad(180);
    elseif num==6
        sat.O = degtorad(260);
        sat.nuo = degtorad(300);
    end
    
elseif (strncmp(satname,'Efir',4))
    sat = SATELITE('Efir','Efir',0,1);
    sat.a   = 1100+6378;         % высоту пересчитать в большую полуось
    sat.ecc = 0;
    sat.inc = degtorad(99.0);
    sat.O   = degtorad(0);
    sat.w   = degtorad(0);        
    sat.nuo = degtorad(0);
    sat.period = 3600*24;
    
    
elseif (strncmp(satname,'KFD-VKK',3))
    sat = SATELITE('KFD-VKK','KFD-VKK',0,1);
    sat.a   = 42162.800;
    sat.ecc = 0.3;
    sat.inc = degtorad(64.8);
    sat.O   = degtorad(200);
    sat.w   = degtorad(269);
    sat.nuo = degtorad(0);
    sat.period = 24*3600;
    sat.nles_lat = 50;
    sat.nles_long = 110;
    sat.nles_minel = 10;
    
    num = dBSat_VKKnum(satname{1},sat.name);
    if num==2
        sat.O = degtorad(80);
        sat.nuo = degtorad(120);
    elseif num==3
        sat.O = degtorad(320);
        sat.nuo = degtorad(240);
    end
    
elseif (strncmp(satname,'GLOk',5))
    sat = SATELITE('GLOk','GLOk',0,1);
    sat.a = 25420;
    sat.ecc = 0;
    sat.inc = degtorad(64.8);
    sat.O   = degtorad(215);
    sat.w   = degtorad(145);
    sat.nuo = degtorad(0);
    sat.period = 11.25*3600;
    
    num = dBSat_VKKnum(satname{1},sat.name);
    if num>1 && num<=10
        sat.w = degtorad(145+(num-1)*36);
    elseif num>10 && num<=20
        sat.O = degtorad(335);
        sat.w = degtorad(145+12+(num-11)*36);
    elseif num>20 && num<=30
        sat.O = degtorad(95);
        sat.w = degtorad(145+24+(num-21)*36);
    end
    
    
elseif (strncmp(satname,'GLO',3))
    sat = SATELITE('GLO','GLO',0,1);
    sat.a = 25420;
    sat.ecc = 0;
    sat.inc = degtorad(64.8);
    sat.O   = degtorad(215);
    sat.w   = degtorad(145);
    sat.nuo = degtorad(0);
    sat.period = 11.25*3600;
    
    num = dBSat_VKKnum(satname{1},sat.name);
    if num>1 && num<=8
        sat.w = degtorad(145+(num-1)*45);
    elseif num>8 && num<=16
        sat.O = degtorad(335);
        sat.w = degtorad(145+15+(num-9)*45);
    elseif num>16 && num<=24
        sat.O = degtorad(95);
        sat.w = degtorad(145+30+(num-17)*45);
    end

    
elseif (strncmp(satname,'GPS',3))
    sat = SATELITE('GPS','GPS',0,1);
    sat.a = 26560;
    sat.ecc = 0;
    sat.inc = degtorad(55);
    sat.O   = degtorad(0);
    sat.w   = degtorad(0);
    sat.nuo = degtorad(0);
    sat.period = 12*3600;
    
    num = dBSat_VKKnum(satname{1},sat.name);
    if num>1 && num<=5
        sat.w = degtorad((num-1)*72);
    elseif num>5 && num<=10
        sat.O = degtorad(60);
        sat.w = degtorad(12+(num-6)*72);
    elseif num>10 && num<=15
        sat.O = degtorad(120);
        sat.w = degtorad(24+(num-11)*72);
 	elseif num>15 && num<=20
        sat.O = degtorad(180);
        sat.w = degtorad(36+(num-16)*72);
   	elseif num>20 && num<=25
        sat.O = degtorad(240);
        sat.w = degtorad(48+(num-21)*72);
    elseif num>25 && num<=30
        sat.O = degtorad(300);
        sat.w = degtorad(60+(num-26)*72);
    end

    
elseif (strncmp(satname,'GAL',3))
    sat = SATELITE('GAL','GAL',0,1);
    sat.a = 29640;
    sat.ecc = 0;
    sat.inc = degtorad(56);
    sat.O   = degtorad(0);
    sat.w   = degtorad(0);
    sat.nuo = degtorad(0);
    sat.period = 12*3600;
    
    num = dBSat_VKKnum(satname{1},sat.name);
    if num>1 && num<=10
        sat.w = degtorad(0+(num-1)*36);
    elseif num>10 && num<=20
        sat.O = degtorad(120);
        sat.w = degtorad(0+12+(num-11)*36);
    elseif num>20 && num<=30
        sat.O = degtorad(240);
        sat.w = degtorad(0+24+(num-21)*36);
    end

elseif (strncmp(satname,'Beidou',6))
    sat = SATELITE('Beidou','Beidou',0,1);
    sat.a = 27848;
    sat.ecc = 0;
    sat.inc = degtorad(55);
    sat.O   = degtorad(0);
    sat.w   = degtorad(0);
    sat.nuo = degtorad(0);
    sat.period = 12*3600;
    
    num = dBSat_VKKnum(satname{1},sat.name);
    if num>1 && num<=9
        sat.w = degtorad(0+(num-1)*40);
    elseif num>9 && num<=18
        sat.O = degtorad(120);
        sat.w = degtorad(0+13+(num-11)*40);
    elseif num>18 && num<=27
        sat.O = degtorad(240);
        sat.w = degtorad(0+26+(num-21)*40);
    end
    
end   


% если нашли в списке ВКК
% if ~strcmp(sat.long,'none')
%     
%     GMSTo = 0;
%     Kepler = [sat.a,sat.ecc,sat.inc,sat.O,sat.w,sat.nuo];
%     dT = 60;                                        % шаг в секундах
%     if sat.period<3600
%         dT = 1;
%     elseif sat.period>3600*24*7
%         dT = 24*3600;
%     end
%     
%     time = [0:dT:sat.period];                       %time vector
%     sat.orbit = orbit_fromKepler(Kepler,GMSTo,time);
%     
%     
% %     long1 = 60;                     % долгота восходящего узла для трассы 1
% %     long2 = 120;                    % долгота восходящего узла для трассы 2
% %     num = dBSat_VKKnum(satname{1},sat.name);
% %     sat.orbit = orbit_VKK1(sat.name,num,long1,long2);
% % %     sat.channel(1).signal = 'L1SBAS';
% % %     sat.channel(1).Ptx = 100;
% % %     sat.channel(1).Ltx = 1.5;
%     return
% end
% 
% 
% % Ресурс-ПМ
% if (strcmp(satname,'Resurs'))
%     sat = SATELITE('Resurs','Resurs',0,1);
%     %sat.orbit = orbit_my(sat.name);
%     return
% end


% если не нашли ни в каком списке
if strcmp(sat.name,'none')
    %fprintf('\nflag2')
    fprintf('\nERROR: unknown satellite name - %s\n',satname{1});
    sat = SATELITE('none','none',0,1);
end

