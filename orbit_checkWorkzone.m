function a = orbit_checkWorkzone(sat,orbit)
% проверка для ВКК, не вышел ли КА за пределы рабочей зоны

    a=1;
    
    % ГСО всегда в рабочей зоне
    if ~strcmp(sat.type,'GEO')
        
        % Вариант 1: угол места с ЗС должен быть не ниже минимально допустимого
        nles_el = calc_elevation (sat.nles_lat,sat.nles_long,orbit,0);
    	if nles_el < sat.nles_minel
         	a=0;
        end
        
	end

end

