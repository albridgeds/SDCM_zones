function plotm_city (color,varargin)



size_city = nargin-1;

for i=1:size_city
    city = varargin{i};
    [lat,long] = dbCity(city);
    plotm(lat,long,'.','Color',color)
end

end


