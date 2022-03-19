function powers = color_power (zone,receiver)
%PLOT_POWER Summary of this function goes here
%   Detailed explanation goes here

Pmin = receiver.Pmin;
Pmax = receiver.Pmax;
dP = receiver.dP;

kmin = min(zone(:));            % минимальное значение в зоне
kmax = max(zone(:));            % максимальное значение в зоне

powers1 = kmin:dP:Pmin-0.5;            % ниже нижнего порога с шагом 1 дЅ

if (kmax>Pmax)
    powers2 = Pmin:dP:Pmax-0.5;        % от нижнего до верхнего порога с шагом 1 дЅ
    powers3 = Pmax:dP:kmax;            % выше верхнего порога с шагом 1 дЅ
else
    powers2 = Pmin:dP:kmax;        	% от нижнего до верхнего порога с шагом 1 дЅ
    powers3 = [];
end

	powers = [powers1 powers2 powers3]; 
    k1 = length(powers1);
    k2 = length(powers2);
    k3 = length(powers3);


% цвета дл€ отображени€ мощности
%cmap_no =	[0.6, 0.6, 0.6];    % серый
cmap_no =	[1.0, 1.0, 1.0];    % белый
cmap_ddr =	[0.8, 0.2, 0.2];    % темно-красный
cmap_dr =	[1.0, 0.2, 0.2];    % темно-красный
cmap_r =	[1.0, 0.4, 0.4];    % красный
cmap_p =	[1.0, 0.6, 0.6];    % розовый
cmap_o =    [1.0, 0.8, 0.6];    % оранжевый
cmap_y =    [1.0, 1.0, 0.6];    % желтый
cmap_yg =   [0.8, 1.0, 0.6];    % желто-зеленый
cmap_g =    [0.6, 1.0, 0.6];    % зеленый
cmap_ggb = 	[0.6, 1.0, 0.8];    % голубой
cmap_bg = 	[0.6, 1.0, 1.0];    % сине-зеленый
cmap_bbg = 	[0.6, 0.8, 1.0];    % синий
cmap_b = 	[0.6, 0.6, 1.0];    % синий
cmap_db = 	[0.4, 0.4, 1.0];    % темно-синий

cmap = cmap_no;

% мощность ниже минимально допустимой
for i=2:k1
    cmap = [cmap;cmap_no];
end

% мощность в допустимых пределах
if (k2>0)
    cmap = [cmap;cmap_db];
end
if (k2>1)
    cmap = [cmap;cmap_b];
end
if (k2>2)
    cmap = [cmap;cmap_bbg];
end
if (k2>3)
    cmap = [cmap;cmap_bg];
end
if (k2>4)
    cmap = [cmap;cmap_ggb];
end
if (k2>5)
    cmap = [cmap;cmap_g];
end
if (k2>6)
    cmap = [cmap;cmap_yg];
end
if (k2>7)
    cmap = [cmap;cmap_y];
end
for i=9:k2
	cmap = [cmap;cmap_o];
end

% мощность выше максимально допустимой
if (k3>0)
    cmap = [cmap;cmap_p];
end
if (k3>1)
    cmap = [cmap;cmap_r];
end
if (k3>2)
    cmap = [cmap;cmap_dr];
end
for i=4:k3
	cmap = [cmap;cmap_ddr];
end


colormap(cmap)

end

