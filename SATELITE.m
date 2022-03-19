classdef SATELITE
    %DBSAT1 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        type    % ГСО, ВКК, ...
        long    % долгота (для ГСО)
        orbit   % орбита (для не-ГСО)
        color   % цвет значка на карте
        
        num
        
        % координаты ЗС
        nles_lat
        nles_long
        nles_minel      % минимально допустимый угол места для закладки сигнала на КА
        
        Lorb;           % !!!КОСТЫЛЬ!!! дополнительное затухание, вносимое в мощность передатчика при приближении КА ВКК к перигею
        angle2north
        angle2east
        
        cur_active;     % вспомогательный параметр (активен ли данный КА в текущий момент времени)
        
        
        % кеплеровские элементы орбиты (для не-ГСО)
        a               % Semi-major axis
        ecc             % Eccentricity
        inc             % Inclination
        O               % RA of ascending node
        w               % Arg of perigee
        nuo             % Mean anomaly
        
        period          % период обращения
        
    end
    
    methods
        
        function obj = SATELITE(name,type,long,num)
            obj.name = name;
            obj.type = type;
            obj.long = long;
            obj.Lorb=0;         % не помню, зачем это. может, вручную вносить изменения в мощность сигнала со спутника
            obj.angle2north=0;
            obj.angle2east=0;
        end
        
    end
    
end

