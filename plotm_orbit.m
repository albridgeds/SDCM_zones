function fig = plotm_orbit (time,satelite,varargin)
% Печать орбит произвольного количества спутников (satelite) с отображением 
% положения спутника в произвольный момент времени (time). Цвет орбит и
% маркера спутника назначается (colorname)



% параметр №3 - цвета (по умолчанию - синий)
if nargin>=3
	colorname = varargin{1};
else
    colorname = 'b';
end

% параметры №4 и №5 - создание нового рисунка и печать в файл
newmap = 0;
plotfile = 0;
for i=1:nargin-2
    if strcmp(varargin{i},'newmap')
        newmap = 1;
    elseif strcmp(varargin{i},'plotfile')
        plotfile = 1;
    end
end


size_sat = length(satelite);

fig = 47;
if (newmap)
    worldmap = create_figure(47);
    %clf
end


for i=1:size_sat
    
    %satName = satelite(i);
    %orbit = dbSat(satName);
    
    if strcmp(satelite(i).name,'none')   % если нет данных, пропускаем этот КА
        continue
    end    
    
    orbit = satelite(i).orbit;    
    color = color_set(colorname,i);
    
    satlat = orbit(:,1);
    satlong = orbit(:,2);

    % если у спутника есть трасса (не ГСО)
    if (size(satlat,1)>1)
        
        plotm(satlat,satlong,'LineWidth',1,'Color',color)       % трасса        
        
        % время, определяющее текущее положение спутника (-1 - последнее время из имеющейся орбиты)
        t = time_index(time,orbit);
        if time==-1
            t = length(satlat);
        end

        % маркер текущего положения спутника
        if satelite(i).cur_active==-1                                                   % принудительно сказано не закрашивать
            plotm(satlat(t),satlong(t),'d','LineWidth',1,'MarkerEdgeColor',color)     
        elseif orbit_checkWorkzone(satelite(i),orbit(t,:))                              % спутник в рабочей зоне (закрасить)
            plotm(satlat(t),satlong(t),'d','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',color)
        else
            plotm(satlat(t),satlong(t),'d','LineWidth',1,'MarkerEdgeColor',color)       % спутник за пределами рабочей зоны (не закрашивать)
        end
        
        
    % если ГСО (координаты постоянны)
    else
        plotm(satlat,satlong,'d','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',color)               % спутник
        
% подпись - название КА и его орбитальная позиция
%         textm(satlat-5,satlong-3,satelite(i).name);
%         satpos = num2str(abs(satelite(i).long));
%         if satelite(i).long<0
%             satpos = strcat(satpos,'W');
%         else
%             satpos = strcat(satpos,'E');
%         end
%         textm(satlat-10,satlong-3,satpos);
    end

end


% сохранение карты в файл
if (newmap)
    plot_map(worldmap);
end
if (plotfile)
    print(worldmap,'-dpng','pictures\\orbit.png');
end