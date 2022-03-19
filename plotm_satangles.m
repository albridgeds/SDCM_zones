function plotm_satangles (time,satelite,receiver,varargin)
% вывод на карту углов возвышения и углов от оси КА на точку



% входной параметр №4 - пользователь (по умолчанию - приземный, высота 0)
% if nargin>=3
% 	user_h = varargin{1}.h;
% else
%     user_h = 0;
% end


% входной параметр №3 - цвета контуров (по умолчанию - синий)
if nargin>=4
	colorname = varargin{1};
else
    colorname = 'b';
end

% входной параметр №4 - угол, по которому ведется расчет (по умолчанию - 5 градусов)
% if nargin>=5
% 	min_el = varargin{3};
% else
%     min_el = 5;
% end

% входные параметры №5 и №6 - создание нового рисунка и печать в файл
newmap = 0;
plotfile = 0;
for i=1:nargin-3
    if strcmp(varargin{i},'newmap')
        newmap = 1;
    elseif strcmp(varargin{i},'plotfile')
        plotfile = 1;
    end
end




% создание зоны, для которой ведется расчет
[lat,long] = zone_earth();

size_sat = length(satelite);


for time_=time
    
    if (newmap)
        worldmap = create_figure(46);
    end
    
    for i=1:size_sat
        sat = satelite(i);
        orbit = sat.orbit;
        
    	if strcmp(satelite(i).name,'none')   % если нет данных, пропускаем этот КА
            continue
        end  
        
        if (size(orbit,1)>1)    % если орбита задана в виде массива точек во времени (не ГСО)
            t = time_index(time_,orbit);
            orbit = orbit(t,:);
        end
        
        %el = calc_elevation(lat,long,orbit,user_h);                % быстрый расчет угла места
        %[el,~,phi,~] = calc_geometry (lat,long,orbit(t,:));
        [el,~,~,phi] = calc_geometry (lat,long,orbit,sat.angle2north,sat.angle2east,receiver.h);
 
        color = color_set(colorname,i);
       


        % угол от оси антенны
        %my_phi = 5;
        %contourm(lat,long,phi,[my_phi my_phi],'g','LineWidth',2);
        contourm(lat,long,phi,0:1:10,'g','LineWidth',1);
        
        % зона видимости по углу 0 градусов 
        min_el = 0;
        contourm(lat,long,el,[min_el min_el],'LineColor',color,'LineWidth',2)
        
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










% % создание зоны, для которой ведется расчет
% [lat,long] = zone_earth();
% 
% min_el = 10;
% my_phi = 8.5;
% %my_phi = 5:1:9;
% 
% for time_=time
% 
%     t = time_index(time_);
%    
%     [el,~,phi,~] = calc_geometry (lat,long,orbit(t,:));
% 
% 
%     worldmap = figure(48);
%     clf
%     axesm('MapProjection','eqdcylin','Frame','on','Grid','on','MeridianLabel','on','ParallelLabel','on');
%     
%     % настройка отображения карты
%     set(worldmap,'Position',[10,50,1200,800]);
%     style = hgexport('factorystyle');
%     style.Bounds = 'tight';
%     hgexport(gcf,'-clipboard',style,'applystyle', true);
%     
%     load mapdata
%     geoshow(ll_world(:,1),ll_world(:,2),'Color','black')
%     russia = load('russia2.dat');
%     plotm(russia(:,1),russia(:,2),'-k','LineWidth',1);
%  
%     
%     % радиовидимость по углу места
%     contourm(lat,long,el,[min_el min_el],'--b','LineWidth',1);              
%     
%     % угол от оси КА
%     contourm(lat,long,phi,[my_phi my_phi],'-b','LineWidth',2);
%     %contourm(lat,long,phi,my_phi);
% 
%     % выводим на печать трассы спутников
%     plot_orbit(orbit,t,1);
%    
%     
%     % сохранение карты в файл
%     filename = sprintf('pictures\\angles_t%04.1f.png',time_);
%     print(worldmap,'-dpng',filename);
%     
%     
%     
% end

