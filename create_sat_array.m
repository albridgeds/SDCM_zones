function sat_array = create_sat_array(varargin)
%CREATE_STR_ARRAY Summary of this function goes here
%   Detailed explanation goes here


% изначальные параметры для обычного набора спутников
satname = 'none';
satlen = nargin;



switch varargin{1}
    
    % ОГ ГЛОНАСС
    case {'GLONASS','GLO','ГЛОНАСС','ГЛО'}
        satlen = 24;
        satname = 'GLO';
    case {'GLONASS-K','GLO-K','ГЛОНАСС-К','ГЛО-К'}
        satlen = 30;
        satname = 'GLOk';
    case {'GPS'}
        satlen = 30;
        satname = 'GPS';
    case {'Galileo','GAL'}
        satlen = 30;
        satname = 'GAL';
    case {'Beidou'}
        satlen = 27;
        satname = 'Beidou';
end
    


satnum = 1:satlen;          % вся группировка


% если был задан обычный набор спутников
if strcmp(satname,'none')
    for i=1:satlen
        sat_array(i) = dbSat(varargin(i));
    end
    
% если была задана ОГ ГНСС    
else
    % если был определен конкретный диапазон НКА в ОГ
    if nargin>=2
        satnum = varargin{2};       % заданные НКА
    end
    
    for i=satnum
        gnss{i} = sprintf('%s-%d',satname,i);
        sat_array(i) = dbSat(gnss(i));
    end     
    
end




% создание орбиты для каждого КА    
for i=satnum
    
    % если есть такой КА
    if ~strcmp(sat_array(i).name,'none')
        
        % если КА ГСО
        if strcmp(sat_array(i).type,'GEO')
            sat_array(i).orbit = orbit_GEO(sat_array(i).long);
            
        % если КА ВКК (временная схема)
        elseif strcmp(sat_array(i).type,'VKK')
            num = dBSat_VKKnum(varargin{i},sat_array(i).name);
            sat_array(i).orbit = orbit_VKK1(sat_array(i).name,num);
            if num<3
                sat_array(i).nles_long = 60;
            else
                sat_array(i).nles_long = 120;
            end
            sat_array(i).nles_lat = 40;
            sat_array(i).nles_minel = 20;
            
        % если КА с орбитой
        else
            sat = sat_array(i);
            Kepler = [sat.a,sat.ecc,sat.inc,sat.O,sat.w,sat.nuo];
            dT = 60;                                        % если период от часа до недели, шаг 1 минута
            if sat.period<3600
                dT = 1;                                     % если период меньше часа, шаг 1 с
            elseif sat.period>3600*24*7
                dT = 3600;                                  % если период больше недели, шаг 1 час
            end

            time = 0:dT:sat.period;                       %time vector
            GMSTo = 0;
            sat_array(i).orbit = orbit_Kepler(Kepler,GMSTo,time);
        end
            
    end
   
end



