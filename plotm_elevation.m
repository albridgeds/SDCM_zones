%function plotm_elevation (time,satelite,user,sat_color,min_el,newmap)
function plotm_elevation (time,satelite,varargin)


% входной параметр №4 - пользователь (по умолчанию - приземный, высота 0)
if nargin>=3
	user_h = varargin{1}.h;
else
    user_h = 0;
end


% входной параметр №3 - цвета контуров (по умолчанию - синий)
if nargin>=4
	colorname = varargin{2};
else
    colorname = 'b';
end

% входной параметр №4 - угол, по которому ведется расчет (по умолчанию - 5 градусов)
if nargin>=5
	min_el = varargin{3};
else
    min_el = 5;
end

% входные параметры №5 и №6 - создание нового рисунка и печать в файл
newmap = 0;
plotfile = 0;
for i=1:nargin-2
    if strcmp(varargin{i},'newmap')
        newmap = 1;
    elseif strcmp(varargin{i},'plotfile')
        plotfile = 1;
    end
end



% Расчет углов места и вывод зон радиовидимости для произвольного времени и количества КА
% На одном графике можно вывести несколько контуров

% вариант вызова 1:
% plot_elevation2(0,satelite,5,'r')             % несколько КА, один момент времени, один контур, один цвет (работает только для встроенных цветов)

% вариант вызова 2:
% plot_elevation2(0,satelite,[5 10],'r')        % несколько контуров для каждого КА

% вариант вызова 3:
% sat_color = create_str_array('green'); 
% plot_elevation2(0,satelite,5,sat_color)       % дополнительные цвета

% вариант вызова 4:
% sat_color = create_str_array('var'); 
% plot_elevation2(0,satelite,5,sat_color)       % свой цвет для каждого КА

% вариант вызова 5:
% sat_color = create_str_array('g','b','b','red'); 
% plot_elevation2(0,satelite,5,sat_color)       % определенный цвет для каждого КА

% вариант вызова 6:
% time = 0:6;
% plot_elevation2(time,satelite,5,sat_color)    % отдельные графики для каждого момента времени




% создание зоны, для которой ведется расчет
[lat,long] = zone_earth();

size_sat = length(satelite);


for time_=time
    
    if (newmap)
        worldmap = create_figure(46);
    end
    
    for i=1:size_sat
        %satName = satelite(i);
        %orbit = dbSat(satName);
        orbit = satelite(i).orbit;
        
    	if strcmp(satelite(i).name,'none')   % если нет данных, пропускаем этот КА
            continue
        end  
        
        if (size(orbit,1)>1)    % если орбита задана в виде массива точек во времени (не ГСО)
            t = time_index(time_,orbit);
            orbit = orbit(t,:);
        end
        
        el = calc_elevation(lat,long,orbit,user_h);                % быстрый расчет угла места
 
        color = color_set(colorname,i);
       
        style = '-';
%         if (i==3)
%             
%             style = '--';
%         end
        
        % рисуем контур 
        contourm(lat,long,el,[min_el(1) min_el(1)],'LineColor',color,'LineWidth',2,'LineStyle',style)

        % если задано несколько значений угла возвышений, остальные контуры рисуем тонкой линией
        if (size(min_el,2)>1)
            contourm(lat,long,el,[min_el min_el],'LineColor',color,'LineWidth',1,'LineStyle',style);
        end
        
        % вывод на печать орбиты КА
        plotm_orbit(time_,satelite,colorname);

    end
    
    
    % дорисовка карты
    if (newmap)
        plot_map(worldmap);
    end
    
    % сохранение карты в файл
    if (plotfile)
        filename = sprintf('pictures\\elevation_t%02g.png',time_);
        print(worldmap,'-dpng',filename);
    end
    
end

